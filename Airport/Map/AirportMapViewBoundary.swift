//
//  AirportMapViewBoundary.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

typealias NearByAirportResponse = (_ errorMessage: String?, _ airportList: [AirportModel]?) -> Void
protocol AirportMapViewBoundary: BaseServiceBoundary {
    func retriveNearbyAirports(latitude: Double,
                               longitude: Double,
                               success: @escaping NearByAirportResponse,
                               failure: @escaping BoundaryFailureBlock)
}
