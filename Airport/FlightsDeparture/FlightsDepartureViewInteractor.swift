//
//  FlightsDepartureViewInteractor.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

struct FlightsDepartureViewInteractor: FlightsDepartureViewBoundary {
    func retriveFlightDepartureTimes(iataCode: String,
                                     success: @escaping FlightsDepartureResponse,
                                     failure: @escaping BoundaryFailureBlock) {
        let queryString = String(format: WebService.flightsDepartureTime, WebService.webAPI_Key, iataCode)
        WebAPIManager.sharedInstance.callWebServiceToFetchDetailsFor(queryparam: queryString) { (status, error, responseData) in
            if status {
                if let data = responseData, let dictionary = AirportModel.retrieveDictionary(from: data) {
                    if let errorInfo = dictionary["error"] as? [String: Any], let errorMessage = errorInfo["text"] as? String  {
                        success(errorMessage, nil)
                    } else {
                        let depatureTimeList = FlightDepartureTimeTableModel.retriveDepartureTimeTable(from: data)
                        success(nil, depatureTimeList)
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
