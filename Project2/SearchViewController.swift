//
//  SearchViewController.swift
//  Project2
//
//  Created by Kudusov Mahmud on 5/12/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit
import GoogleMaps

class POIItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String!

    init(position: CLLocationCoordinate2D, name: String) {
        self.position = position
        self.name = name
    }
}

class SearchViewController: UIViewController, GMUClusterManagerDelegate, GMSMapViewDelegate  {

    private var mapView: GMSMapView?
    private var clusterManager: GMUClusterManager!
    private var newManager = LocationManager(handler: {(location: CLLocation) -> Void in }, distanceFilter: 1)
    private var currentLocation: CLLocation = CLLocation(latitude: +55.75578600, longitude: +37.61763300)
    private var all_cafes: [TimeCafeJson] = []
    private var currentLocationMarker = GMSMarker(position: CLLocationCoordinate2D(latitude: +55.75578600, longitude: +37.61763300))

    override func viewDidLoad() {
        super.viewDidLoad()

        newManager = LocationManager(handler: self.updateTableAfterLocationChanging)
        currentLocation = newManager.getCurrentLocation()

        let camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView

        currentLocationMarker.title = "Yoy are here"

        currentLocationMarker.icon = GMSMarker.markerImage(with: .blue)
        currentLocationMarker.map = mapView
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView!, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView!, algorithm: algorithm, renderer: renderer)
        clusterManager.setDelegate(self, mapDelegate: self)
        uploadCafes()
    }

    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
                                                 zoom: mapView!.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView!.moveCamera(update)
        return false
    }

    let timeCafeMapInfoLauncher = TimeCafeMapInfoLauncher()
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let poiItem = marker.userData as? POIItem {
//            print("Did tap marker for cluster item \(poiItem.name)")
            timeCafeMapInfoLauncher.closeSettings()
            timeCafeMapInfoLauncher.showSettings(timeCafeInfo: self.all_cafes[Int(poiItem.name) ?? 0])
        } else {
            timeCafeMapInfoLauncher.closeSettings()
            print("Did tap a normal marker")
        }

        return false
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        timeCafeMapInfoLauncher.closeSettings()
    }
    func updateTableAfterLocationChanging(_ location: CLLocation) -> Void {
        self.currentLocation = location
        print("update map")
        updateCurrentLocation()
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
            let item = POIItem(position: CLLocationCoordinate2DMake(cafe.latitude, cafe.longtitude), name: String(id))
            clusterManager.add(item)

        }
        clusterManager.cluster()
    }

    private func updateCurrentLocation() {
        print("update")
        self.currentLocationMarker.position.latitude = currentLocation.coordinate.latitude
        self.currentLocationMarker.position.longitude = currentLocation.coordinate.longitude
    }


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

    var myView = MyView(frame: CGRect(x: 40, y: 40, width: 350, height: 300))

    func showSettings(timeCafeInfo: TimeCafeJson) {
        if let window = UIApplication.shared.keyWindow {
            myView.backgroundColor = .white
            myView.nameLabel.text = timeCafeInfo.name
            myView.nameLabel.textColor = .black
            myView.distanceLabel.text = "~10 km"
            myView.ratingLabel.text = "Рейтинг 4.7 из 5"
            myView.stationLabel.text = timeCafeInfo.station
            myView.addressLabel.text = timeCafeInfo.address
            myView.timeLabel.text = "10:00 - 22:00"
            myView.phoneNumber.text = timeCafeInfo.phone_number
            window.addSubview(myView)
            myView.addFeatureIcon(feature: FeatureType.playstation)
            myView.addFeatureIcon(feature: FeatureType.board_games)
            myView.addFeatureIcon(feature: FeatureType.rooms)
            myView.addFeatureIcon(feature: FeatureType.musical_instrument)
            myView.addFeatureIcon(feature: FeatureType.hookah)
            let height: CGFloat = 300
            let y = window.frame.height - height
            myView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.myView.frame = CGRect(x: 0, y: y, width: self.myView.frame.width, height: self.myView.frame.height)

            }, completion: nil)

        }
    }


    func showSettings2() {
        //show menu
        if let window = UIApplication.shared.keyWindow {

            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)

            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))

            window.addSubview(blackView)

//            myView.backgroundColor = .white
            window.addSubview(collectionView)
            let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleDismiss2))
            swipeUp.direction = UISwipeGestureRecognizer.Direction.up
            collectionView.addGestureRecognizer(swipeUp)
//            collectionView.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(handleDismiss2)))
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

    
    override init() {
        super.init()
        //start doing something here maybe....
    }

}
