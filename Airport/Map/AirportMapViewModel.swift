//
//  AirportMapViewModel.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol AirportMapViewModelDelegate {
    func refreshMap(with list: [AirportModel]?)
    func showFailure(with error: String?)
}

struct AirportMapViewModel {
    private(set) var currentLocation: CLLocation?
    
    var nearbyAirportList: [AirportModel]?
    private var delegate: AirportMapViewModelDelegate?
    private var interactor: AirportMapViewBoundary?
    private var dataTransporter: ViewDataTransporter?

    init(delegate: AirportMapViewModelDelegate, interactor: AirportMapViewBoundary,
         dataTransporter: ViewDataTransporter?) {
        self.delegate = delegate
        self.interactor = interactor
        self.dataTransporter = dataTransporter
    }
    
    var selectedAirport: AirportModel? {
        get {
            return dataTransporter?.selectedAirport
        }
        set {
            dataTransporter?.selectedAirport = newValue
        }
    }

    //MARK: - User-defined
    
    mutating func selectedAirport(at annotation: MKAnnotation) {
        selectedAirport = nearbyAirportList?.first(where: { (airport) -> Bool in
            if Double(airport.latitude ?? "0.00") == annotation.coordinate.latitude, Double(airport.longitude ?? "0.00") == annotation.coordinate.longitude {
                return true
            } else {
                return false
            }
        })
    }
    
    mutating func updateCurrentLocationWith(location: CLLocation) {
        currentLocation = location
    }
    
    func retrieveNearByAirports() {
        let latitude = currentLocation?.coordinate.latitude ?? 0.0
        let longitude = currentLocation?.coordinate.longitude ?? 0.0
        interactor?.retriveNearbyAirports(latitude: latitude, longitude: longitude, success: { (errorMessage, airportList) in
            if errorMessage == nil {
                self.delegate?.refreshMap(with: airportList)
            } else {
                self.delegate?.showFailure(with: errorMessage)
            }
        }, failure: { (error) in
            self.delegate?.showFailure(with: error)
        })
    }
    
    func retriveStubResponse() {
        do {
            if let filepath = Bundle.main.path(forResource: "NearByAirports", ofType: "json") {
                let decoder = JSONDecoder()
                let data = try Data(contentsOf: URL(fileURLWithPath: filepath))
                let list = try decoder.decode([AirportModel].self, from: data)
                self.delegate?.refreshMap(with: list)
            } else {
                self.delegate?.refreshMap(with: nil)
            }
        } catch {
            self.delegate?.refreshMap(with: nil)
        }
    }
}
