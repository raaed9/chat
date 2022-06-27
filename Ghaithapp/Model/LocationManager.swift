//
//  LocationManager.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 09/11/1443 AH.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D?
    
    private override init() {
        super.init()
        self.requestLocationAccess()
        
        
    }
    
    func requestLocationAccess() {
        
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.requestWhenInUseAuthorization()
            
        } else {
            print("we have already location manager")
        }
    }
    
    
    func startUpdating() {
        
        locationManager!.startUpdatingLocation()
    }
    
    func stopUpdating() {
        
        if locationManager != nil {
            locationManager!.stopUpdatingLocation()
        }
    }
    
    //MARK: - Delegate function
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last!.coordinate
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("failed to get location", error.localizedDescription)
        
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if manager.authorizationStatus == .notDetermined {
            self.locationManager!.requestWhenInUseAuthorization()
        }
    }
}
