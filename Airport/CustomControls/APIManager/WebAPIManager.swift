//
//  WebAPIManager.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

class WebAPIManager: NSObject {
    static let sharedInstance = WebAPIManager()
    
    // A method to handle multiple web-service calls
    func callWebServiceToFetchDetailsFor(queryparam: String, completionHandler: @escaping(_ result: Bool, _ error: String?, _ value: Data?) -> Swift.Void) {
        var fullweburl = WebService.webAPI_URL
        fullweburl = fullweburl + String(format: queryparam, WebService.webAPI_Key)
        fullweburl = fullweburl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let requestUrl = URL(string: fullweburl)
        guard requestUrl != nil else {
            completionHandler(false, "invalid_url".localised(), nil)
            return
        }
        var request = URLRequest(url: requestUrl!)
        request.timeoutInterval = 120
        request.cachePolicy = .returnCacheDataElseLoad
        request.allHTTPHeaderFields = [WebService.WebServiceRequestHeaderKey.soapHeader_ContentType_Key: WebService.WebServiceRequestHeaderKey.requestResponseContentType]
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let task = session.dataTask(with: request) { (data, response, error) in
            let httpresponse = response as? HTTPURLResponse
            if httpresponse?.statusCode == APIResponseCode.success.rawValue {
                if let respondata = data {
                    completionHandler(true, nil, respondata)
                } else {
                    completionHandler(false, "no_record_found".localised(), nil)
                }
            } else {
                if let errr = error {
                    completionHandler(false, errr.localizedDescription, nil)
                } else if let statuscode = httpresponse?.statusCode {
                    let message = HTTPURLResponse.localizedString(forStatusCode: statuscode)
                    completionHandler(false, message, nil)
                } else {
                    completionHandler(false, "api_something_went_wrong".localised(), nil)
                }
            }
        }
        task.resume()
    }
}


// MARK: - ================================
// MARK: URLSession Delegate Methods
// MARK: ================================

extension WebAPIManager: URLSessionDelegate {
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print(error?.localizedDescription as Any)
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
    }
}
