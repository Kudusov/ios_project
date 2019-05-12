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

    let settings = SettingsLauncher()
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let poiItem = marker.userData as? POIItem {
            print("Did tap marker for cluster item \(poiItem.name)")
            settings.showSettings()
        } else {
            print("Did tap a normal marker")
        }

        return false
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

        for cafe in all_cafes{
            let item = POIItem(position: CLLocationCoordinate2DMake(cafe.latitude, cafe.longtitude), name: String(cafe.id))
            clusterManager.add(item)

        }
        clusterManager.cluster()
    }

    private func updateCurrentLocation() {
        print("update")
        self.currentLocationMarker.position.latitude = currentLocation.coordinate.latitude
        self.currentLocationMarker.position.longitude = currentLocation.coordinate.longitude
    }

    func next() {
        print("\n\n        next func called            \n\n")
        let nextLocation = CLLocationCoordinate2D(latitude: 37.792871, longitude: -122.397055)
        mapView?.animate(to: GMSCameraPosition.camera(withLatitude: nextLocation.latitude, longitude: nextLocation.longitude, zoom: 12))

        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: nextLocation.latitude, longitude: nextLocation.longitude))
        marker.title = "SFO Airport"
        marker.snippet = "Some snippet hahahah"
        marker.map = mapView

    }


}


class MyView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.addSubview(nameLabel)
        self.addSubview(distanceLabel)
        self.addSubview(ratingLabel)
        self.addSubview(addressLabel)
        self.addSubview(stationLabel)
        self.addSubview(timeLabel)
        self.addSubview(priceLabel)
    }

    var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    var distanceLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    var ratingLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    var addressLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    var stationLabel: UILabel = {
        let label = UILabel()
        return label
    }()


    var timeLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    var phoneNumber: UILabel = {
        let label = UILabel()
        return label
    }()

    var priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
}
class SettingsLauncher: NSObject {

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

    var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    var distanceLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    var ratingLabel: UILabel = {
        let label = UILabel()
        return label
    }()


    func showSettings() {
        //show menu

        if let window = UIApplication.shared.keyWindow {

            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)

            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))

            window.addSubview(blackView)

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

                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)

            }, completion: nil)
        }
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
