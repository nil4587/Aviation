//
//  FlightsDepartureViewBoundary.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

typealias FlightsDepartureResponse = (_ error: String?, _ flightDepartureInfo: [FlightDepartureTimeTableModel]?) -> Void
protocol FlightsDepartureViewBoundary: BaseServiceBoundary {
    func retriveFlightDepartureTimes(iataCode: String,
                                     success: @escaping FlightsDepartureResponse,
                                     failure: @escaping BoundaryFailureBlock)
}
