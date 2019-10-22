//
//  MapViewInteractor.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

struct AirportMapViewInteractor: AirportMapViewBoundary {
    func retriveNearbyAirports(latitude: Double,
                               longitude: Double,
                               success: @escaping NearByAirportResponse,
                               failure: @escaping BoundaryFailureBlock) {
        let queryString = String(format: WebService.nearByAirports, WebService.webAPI_Key, latitude, longitude)
        WebAPIManager.sharedInstance.callWebServiceToFetchDetailsFor(queryparam: queryString) { (status, error, responseData) in
            if status {
                if let data = responseData, let dictionary = AirportModel.retrieveDictionary(from: data) {
                    if let errorInfo = dictionary["error"] as? [String: Any], let errorMessage = errorInfo["text"] as? String  {
                        success(errorMessage, nil)
                    } else {
                        let airportList = AirportModel.retriveAirportList(from: data)
                        success(nil, airportList)
                    }
                } else {
                    failure("no_data".localised())
                }
            } else {
                failure(error!)
            }
        }
    }
}
