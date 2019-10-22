//
//  Enumerations.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation


// Server response code
enum APIResponseCode: Int {
    case success = 200
    case servererror = 500
}

// API Module
enum APIModule: Int8 {
    case nearByAirports
    case departureSchedule
}
