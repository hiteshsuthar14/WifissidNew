//
//  Model.swift
//  WifissidNew
//
//  Created by Hitesh Suthar on 30/09/22.
//

import Foundation
import NetworkExtension
import CoreLocation
// class added
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    override init() {
        super.init()
        guard locationManager == nil else {
                    locationManager?.requestWhenInUseAuthorization()
                    locationManager?.startUpdatingLocation()
                    return
        }
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
    }
    func fetchCurrentNetwork() {
        NEHotspotNetwork.fetchCurrent(completionHandler: { (network) in
            if let unwrappednetwork = network {
                let networkssid = unwrappednetwork.ssid
                print(networkssid) } else {
                    print("no network available")
                }
      })
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            /* Detect the CLAuthorizationStatus and enable the capture of associated SSID. */
            if status == CLAuthorizationStatus.authorizedAlways ||
                status == CLAuthorizationStatus.authorizedWhenInUse  {
                fetchCurrentNetwork()
            }
        }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            print("no location found")
            return
        }
        print("last location was \(locations)")
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            if let error = error as? CLError, error.code == .denied {
                print(error.localizedDescription)
            manager.stopUpdatingLocation()
            }
        }
}

