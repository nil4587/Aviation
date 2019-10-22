//
//  AirportModel.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

struct AirportModel {
    private(set) var nameAirport: String?
    private(set) var codeIataAirport: String?
    private(set) var codeIcaoAirport: String?
    private(set) var latitude: String?
    private(set) var longitude: String?
    private(set) var timeZone: String?
    private(set) var gmtDifference: String?
    private(set) var phone: String?
    private(set) var nameCountry: String?
    private(set) var codeIso2Country: String?
    private(set) var codeIataCity: String?
    private(set) var distance: String?
    
    enum CodingKeys: String, CodingKey {
        case nameAirport, codeIataAirport, codeIcaoAirport
        case latitude = "latitudeAirport", longitude = "longitudeAirport"
        case gmtDifference = "GMT", timeZone = "timezone"
        case phone, nameCountry, codeIso2Country, codeIataCity, distance
    }
    
    //MARK: - User-defined
    
    static func retriveAirportList(from data: Data) -> [AirportModel]? {
        do {
            let decoder = JSONDecoder()
            let list = try decoder.decode([AirportModel].self, from: data)
            return list
        } catch {
            return nil
        }
    }
    
    static func retrieveDictionary(from data: Data) -> [String: Any]? {
        do {
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            print(dictionary.debugDescription)
            return dictionary
        } catch {
            return nil
        }
    }
}

//MARK: - Decodable

extension AirportModel: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nameAirport = try container.decodeIfPresent(String.self, forKey: .nameAirport)
        codeIataAirport = try container.decodeIfPresent(String.self, forKey: .codeIataAirport)
        codeIcaoAirport = try container.decodeIfPresent(String.self, forKey: .codeIcaoAirport)
        latitude = try container.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(String.self, forKey: .longitude)
        timeZone = try container.decodeIfPresent(String.self, forKey: .timeZone)
        gmtDifference = try container.decodeIfPresent(String.self, forKey: .gmtDifference)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        nameCountry = try container.decodeIfPresent(String.self, forKey: .nameCountry)
        timeZone = try container.decodeIfPresent(String.self, forKey: .timeZone)
        codeIso2Country = try container.decodeIfPresent(String.self, forKey: .codeIso2Country)
        codeIataCity = try container.decodeIfPresent(String.self, forKey: .codeIataCity)
        distance = try container.decodeIfPresent(String.self, forKey: .distance)
    }
}
