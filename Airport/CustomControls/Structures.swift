//
//  Structures.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ================================
// MARK: Appliation Informations
// MARK: ================================

struct AppInfo {
    
    /// A parameter which returns Application Title
    static var title: String {
        if let infoDict = Bundle.main.infoDictionary, let title = infoDict["CFBundleDisplayName"] as? String {
            return title
        } else {
            return "Aviation"
        }
    }
    
    /// A parameter which returns Application version
    static var appVersion: String {
        if let infoDict = Bundle.main.infoDictionary, let version = infoDict["CFBundleShortVersionString"] as? String {
            return version
        } else {
            return "1.0"
        }
    }
    
    /// A parameter which returns Build version
    static var buildVersion: String {
        if let infoDict = Bundle.main.infoDictionary, let version = infoDict["CFBundleVersion"] as? String {
            return version
        } else {
            return "1.0"
        }
    }
    
    /// A parameter which returns Application Delegate
    static var sceneDelegate: SceneDelegate? {
        return UIApplication.shared.delegate as? SceneDelegate
    }
}

// MARK: - ================================
// MARK: Web-service informations
// MARK: ================================

struct WebService {
    //http://aviation-edge.com/api/public/nearby?key=api_key&lat=0.0&lng=0.0&distance=1
    static let webAPI_Key = "9647f0-145193"
    static let webAPI_URL = "http://aviation-edge.com/api/public/"
    
    /// A structure which keeps web-service request's keys
    struct WebServiceRequestHeaderKey {
        static let httpMethod_GET_Key = "GET"
        static let soapHeader_ContentType_Key = "Content-Type"
        static let soapHeader_Accept_Key = "Accept"
        
        //-- webservice request/response content type
        static let requestResponseContentType = "application/json;charset=UTF-8"
    }
    
    static var nearByAirports: String {
        return "nearby?key=%@&lat=%lf&lng=%lf&distance=100"
    }
    
    static var flightsDepartureTime: String {
        return "timetable?key=%@&iataCode=%@&type=departure"
    }
}

// MARK: - ================================
// MARK: Other application constants
// MARK: ================================

struct Constants {
    // Keys used within the application
    struct AppKeys {
        static let webApiKeyTitle = "apikey"
        static let webApiQueue = "WebAPI_Queue"
    }
}
