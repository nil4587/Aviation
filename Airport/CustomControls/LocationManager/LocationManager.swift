//
//  LocationManager.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerServiceDelegate {
    func locationDidUpdateToLocation(currentLocation: CLLocation)
    func locationUpdateDidFailWithError(error: Error)
}

class LocationManager: NSObject {
    static let sharedInstance = LocationManager()
    var delegate: LocationManagerServiceDelegate?
    var updatedLocation: CLLocation?
    
    /// Core location
    private var locationManager: CLLocationManager?

    override init() {
        super.init()
        
        guard CLLocationManager.locationServicesEnabled() else {
            return
        }
        locationManager =  CLLocationManager()
        locationManager?.delegate = self
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager?.requestWhenInUseAuthorization()
        }
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.distanceFilter = 0.1
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
            case .notDetermined:
                locationManager?.requestWhenInUseAuthorization()
                break
            case .authorizedWhenInUse:
                locationManager?.startUpdatingLocation()
                break
            case .authorizedAlways:
                locationManager?.startUpdatingLocation()
                break
            case .restricted:
                // restricted by e.g. parental controls. User can't enable Location Services
                break
            case .denied:
                // user denied your app access to Location Services, but can grant access from Settings.app
                break
            default:
                break
        }
    }
    
    //MARK: - User-defined
    
    func startUpdatingLocation() {
        locationManager?.startUpdatingLocation()
        #if DEBUG
        print("Starting Location Updates")
        #endif
    }
    
    func stopUpdatingLocation() {
        locationManager?.stopUpdatingLocation()
        #if DEBUG
        print("Stop Location Updates")
        #endif
    }
    
    func startMonitoringSignificantLocationChanges() {
        locationManager?.startMonitoringSignificantLocationChanges()
    }
}

//MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        updatedLocation = location
        delegate?.locationDidUpdateToLocation(currentLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        #if DEBUG
        print("Location Manager Error : \(error.localizedDescription)")
        #endif
        delegate?.locationUpdateDidFailWithError(error: error)
    }
}
