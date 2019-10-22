//
//  FlightDepartureTimeTableModel.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

//MARK: - Airline

struct Airline {
    private(set) var name: String?
    private(set) var iataCode: String?
    private(set) var icaoCode: String?
    
    enum CodingKeys: String, CodingKey {
        case name, iataCode, icaoCode
    }
}

//MARK: - Flight

struct Flight {
    private(set) var number: String?
    private(set) var iataNumber: String?
    private(set) var icaoNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case number, iataNumber, icaoNumber
    }
}

//MARK: - FlightDepartureTimeTableModel

struct FlightDepartureTimeTableModel {
    private(set) var type: String?
    private(set) var status: String?
    private(set) var departure: FlightsArrivalDepartureModel?
    private(set) var arrival: FlightsArrivalDepartureModel?
    private(set) var codeshared: String?
    private(set) var flight: Flight?
    private(set) var airline: Airline?
    
    enum CodingKeys: String, CodingKey {
        case type, status, departure
        case arrival, codeshared, flight, airline
    }
    
    //MARK: - User-defined
        
    static func retriveDepartureTimeTable(from data: Data) -> [FlightDepartureTimeTableModel]? {
        do {
            let decoder = JSONDecoder()
            let list = try decoder.decode([FlightDepartureTimeTableModel].self, from: data)
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

extension Airline: Decodable {
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            iataCode = try container.decodeIfPresent(String.self, forKey: .iataCode)
            icaoCode = try container.decodeIfPresent(String.self, forKey: .icaoCode)
        } catch {
            print("Airline : \(error.localizedDescription)")
        }
    }
}

extension Flight: Decodable {
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            number = try container.decodeIfPresent(String.self, forKey: .number)
            iataNumber = try container.decodeIfPresent(String.self, forKey: .iataNumber)
            icaoNumber = try container.decodeIfPresent(String.self, forKey: .icaoNumber)
        } catch {
            print("Flight : \(error.localizedDescription)")
        }
    }
}

extension FlightDepartureTimeTableModel: Decodable {
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            type = try container.decodeIfPresent(String.self, forKey: .type)
            status = try container.decodeIfPresent(String.self, forKey: .status)
            departure = try container.decodeIfPresent(FlightsArrivalDepartureModel.self, forKey: .departure)
            arrival = try container.decodeIfPresent(FlightsArrivalDepartureModel.self, forKey: .arrival)
            codeshared = try container.decodeIfPresent(String.self, forKey: .codeshared)
            flight = try container.decodeIfPresent(Flight.self, forKey: .flight)
            airline = try container.decodeIfPresent(Airline.self, forKey: .airline)
        } catch {
            print("FlightDepartureTimeTableModel : \(error.localizedDescription)")
        }
    }
}
