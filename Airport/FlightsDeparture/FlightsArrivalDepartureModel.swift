//
//  FlightsArrivalDepartureModel.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/14.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

struct FlightsArrivalDepartureModel {
    private(set) var iataCode: String?
    private(set) var icaoCode: String?
    private(set) var terminal: String?
    private(set) var gate: String?
    private(set) var baggage: String?
    private(set) var delay: String?
    private(set) var scheduledTime: String?
    private(set) var estimatedTime: String?
    private(set) var actualTime: String?
    private(set) var estimatedRunway: String?
    private(set) var actualRunway: String?
    
    enum CodingKeys: String, CodingKey {
        case iataCode, icaoCode, terminal
        case gate, baggage, delay
        case scheduledTime, estimatedTime, actualTime
        case estimatedRunway, actualRunway
    }
}

//MARK: - Decodable

extension FlightsArrivalDepartureModel: Decodable {
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            iataCode = try container.decodeIfPresent(String.self, forKey: .iataCode)
            icaoCode = try container.decodeIfPresent(String.self, forKey: .icaoCode)
            terminal = try container.decodeIfPresent(String.self, forKey: .terminal)
            gate = try container.decodeIfPresent(String.self, forKey: .gate)
            baggage = try container.decodeIfPresent(String.self, forKey: .baggage)
            delay = try container.decodeIfPresent(String.self, forKey: .delay)
            scheduledTime = try container.decodeIfPresent(String.self, forKey: .scheduledTime)
            estimatedTime = try container.decodeIfPresent(String.self, forKey: .estimatedTime)
            actualTime = try container.decodeIfPresent(String.self, forKey: .actualTime)
            estimatedRunway = try container.decodeIfPresent(String.self, forKey: .estimatedRunway)
            actualRunway = try container.decodeIfPresent(String.self, forKey: .actualRunway)
        } catch {
            print("FlightsArrivalDepartureModel : \(error.localizedDescription)")
        }
    }
}
