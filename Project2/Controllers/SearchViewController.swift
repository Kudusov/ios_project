//
//  SearchViewController.swift
//  Project2
//
//  Created by Kudusov Mahmud on 5/12/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit
import GoogleMaps


class SearchViewController: UIViewController, GMSMapViewDelegate{

    private var mapView: GMSMapView?
    private var clusterManager: GMUClusterManager!
    private var newManager = LocationManager(handler: {(location: CLLocation) -> Void in }, distanceFilter: 1)
    private var currentLocation: CLLocation = CLLocation(latitude: +55.75578600, longitude: +37.61763300)
    private var all_cafes: [TimeCafeJson] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        newManager = LocationManager(handler: self.updateTableAfterLocationChanging)
        currentLocation = newManager.getCurrentLocation()


        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView?.isMyLocationEnabled = true
        mapView?.settings.myLocationButton = true
        mapView?.padding = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        view = mapView

        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView!, clusterIconGenerator: iconGenerator)
        renderer.delegate = self

        clusterManager = GMUClusterManager(map: mapView!, algorithm: algorithm, renderer: renderer)
        clusterManager.setDelegate(self, mapDelegate: self)
        uploadCafes()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func getUserLocationView() -> UIView {
        let markerView = CustomTimeCafeMarker(frame: CGRect(x: 0, y: 0, width: 50, height: 60))
        markerView.imageView.image = UIImage(named: "icons8-current-location2-40")
        markerView.label.text = "You"
        markerView.label.alpha = 0
        return markerView
    }

    let timeCafeMapInfoLauncher = TimeCafeMapInfoLauncher()
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let markerModel = marker.userData as? TimeCafeMarkerModel {
            timeCafeMapInfoLauncher.closeSettings()
            timeCafeMapInfoLauncher.showSettings(timeCafeInfo: self.all_cafes[markerModel.arrayId], userLocation: currentLocation)
        } else {
            timeCafeMapInfoLauncher.closeSettings()
        }

        return false
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        timeCafeMapInfoLauncher.closeSettings()
    }

    func updateTableAfterLocationChanging(_ location: CLLocation) -> Void {
        self.currentLocation = location
//        updateCurrentLocation()
    }

    private func uploadCafes() {
        let session = URLSession.shared
        session.dataTask(with: URL(string: baseUrl + "/api/cafes/")!) { (data, response, error) in
            guard let data = data else {
                print("no data, error: \(error?.localizedDescription ?? "unknown error")")

                return
            }

            let decoder = JSONDecoder()
            guard let timecafes: [TimeCafeJson] = try? decoder.decode([TimeCafeJson].self, from: data) else {
                print("error")

                return
            }

            DispatchQueue.main.async { [weak self] in
                self?.all_cafes = timecafes
                self?.generateClusterItems()
            }

            }.resume()

    }

    private func generateClusterItems() {


        for (id, cafe) in all_cafes.enumerated(){
            let item = TimeCafeMarkerModel(position: CLLocationCoordinate2DMake(cafe.latitude, cafe.longtitude), name: cafe.name, arrayId: id, id: cafe.id)
            clusterManager.add(item)

        }
        clusterManager.cluster()
    }

    private func updateCurrentLocation() {
        print("update")
//        self.currentLocationMarker.position.latitude = currentLocation.coordinate.latitude
//        self.currentLocationMarker.position.longitude = currentLocation.coordinate.longitude
    }


}

extension SearchViewController: GMUClusterManagerDelegate {
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
                                                 zoom: mapView!.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView!.moveCamera(update)
        return false
    }
}
extension SearchViewController: GMUClusterRendererDelegate {
    func renderer(_ renderer: GMUClusterRenderer, markerFor object: Any) -> GMSMarker? {
        let marker = GMSMarker()
        if let markerModel = object as? TimeCafeMarkerModel {
            let timecafe = self.all_cafes[markerModel.arrayId]
            print(timecafe.name)
            let mark = CustomTimeCafeMarker(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
            mark.imageView.image = UIImage(named: "coffee")
            mark.label.text = markerModel.name
            print(mapView!.camera.zoom)
            if mapView!.camera.zoom >= 13 {
                mark.label.alpha = 1
            } else {
                mark.label.alpha = 0
            }
            marker.iconView = mark

        }

        return marker
    }

    //    func renderer(_ renderer: GMUClusterRenderer, didRenderMarker marker: GMSMarker) {
    //        marker.groundAnchor = CGPoint(x: 0.5, y: 1)
    //        print("hellooo")
    //        if  let markerData = (marker.userData as? POIItem) {
    ////            let icon = markerData.imageURL
    //            marker.icon = UIImage(named: "icons8-current-location2-40")
    //            marker.iconView = nil
    //        }
    //    }
}




class TimeCafeMapInfoLauncher: NSObject {

    let blackView = UIView()

    var collectionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

    var anotherView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
     }()

    var anotherView2: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    var myView = MyView(frame: CGRect(x: 40, y: 40, width: 350, height: 300))

    func showSettings(timeCafeInfo: TimeCafeJson, userLocation: CLLocation) {
        if let window = UIApplication.shared.keyWindow {

            myView.backgroundColor = .white
            myView.nameLabel.text = timeCafeInfo.name
            myView.nameLabel.textColor = .black
            let distance: Double = userLocation.distance(from: CLLocation(latitude: timeCafeInfo.latitude, longitude: timeCafeInfo.longtitude))

            var destinationType = " км"
            var destination = String(format: "%.1f", distance / 1000.0)
            if (distance > 10000) {
                destination = String(format: "%.0f", distance / 1000.0)
            }
            if (distance < 1000) {
                destination = String(format: "%.0f", floor(distance))
                destinationType = " м"
            }

            myView.distanceLabel.text = "~" + destination + destinationType
            myView.ratingLabel.text = "Рейтинг 4.7 из 5"
            myView.stationLabel.text = timeCafeInfo.station
            myView.addressLabel.text = timeCafeInfo.address
            myView.timeLabel.text = "10:00 - 22:00"
            myView.phoneNumber.text = timeCafeInfo.phone_number
            for feature in timeCafeInfo.features ?? [Feature]() {
                myView.addFeatureIcon(feature: feature.feature)
            }
            window.addSubview(myView)

            let height: CGFloat = 300
            let y = window.frame.height - height
            myView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.myView.frame = CGRect(x: 0, y: y, width: self.myView.frame.width, height: self.myView.frame.height)

            }, completion: nil)

            let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownView))
            swipeDownGesture.direction = UISwipeGestureRecognizer.Direction.down
            myView.addGestureRecognizer(swipeDownGesture)
        }
    }


    func showSettings2() {
        //show menu
        if let window = UIApplication.shared.keyWindow {

            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)

            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))

            window.addSubview(blackView)

            window.addSubview(collectionView)
            collectionView.addSubview(anotherView)
            collectionView.addSubview(anotherView2)

            anotherView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            anotherView2.translatesAutoresizingMaskIntoConstraints = false
            anotherView2.topAnchor.constraint(equalTo: anotherView.bottomAnchor, constant: 10).isActive = true
            anotherView2.widthAnchor.constraint(equalToConstant: 100).isActive = true
            anotherView2.heightAnchor.constraint(equalToConstant: 1).isActive = true
            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleDismiss2))
            swipeUp.direction = UISwipeGestureRecognizer.Direction.up
            collectionView.addGestureRecognizer(swipeUp)
            let height: CGFloat = 200
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)

            blackView.frame = window.frame
            blackView.alpha = 0

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

                self.blackView.alpha = 1

                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.myView.frame.height)

            }, completion: nil)
        }
    }

    func closeSettings() {
        UIView.animate(withDuration: 0.5) {

            if let window = UIApplication.shared.keyWindow {
                self.myView.frame = CGRect(x: 0, y: window.frame.height, width: self.myView.frame.width, height: self.myView.frame.height)
            }
        }
        myView = MyView(frame: CGRect(x: 40, y: 40, width: 350, height: 300))
    }

    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0

            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }

    }

    @objc func handleDismiss2() {
        UIView.animate(withDuration: 3) {
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height - 700, width: self.collectionView.frame.width, height: self.collectionView.frame.height + 700)

            }
            self.collectionView.addSubview(self.anotherView)
            self.anotherView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        }
    }

    @objc func swipeDownView() {
        closeSettings()
    }

    override init() {
        super.init()
        //start doing something here maybe....
    }

}
