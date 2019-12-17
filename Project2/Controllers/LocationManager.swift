import UIKit
import CoreLocation

class LocationManager: NSObject,  CLLocationManagerDelegate {

    typealias MethodHandler1 = (_ location: CLLocation) -> Void;
    let manager = CLLocationManager()
    var currentLocation: CLLocation = CLLocation(latitude: +55.75578600, longitude: +37.61763300)
    let handler: MethodHandler1



    init(handler: @escaping MethodHandler1, distanceFilter: Int = 100) {
        self.handler = handler
        super.init()
        manager.requestWhenInUseAuthorization()
        manager.distanceFilter = CLLocationDistance(distanceFilter)

        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            if (distanceFilter == 100) {
                manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            } else {
                manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            }
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.currentLocation = location
            print("Found user's location: \(location)")
            self.handler(currentLocation)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }

    func getCurrentLocation() -> CLLocation {
        return self.currentLocation
    }

}
