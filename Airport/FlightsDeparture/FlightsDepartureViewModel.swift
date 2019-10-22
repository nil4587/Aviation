//
//  FlightsDepartureViewModel.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

protocol FlightsDepartureViewModelDelegate  {
    func refreshList(with list: [FlightDepartureTimeTableModel]?)
    func showFailure(with error: String?)
}

struct FlightsDepartureViewModel {
    
    private var delegate: FlightsDepartureViewModelDelegate?
    private var interactor: FlightsDepartureViewBoundary?
    private var dataTransporter: ViewDataTransporter?
    var departureTimeList: [FlightDepartureTimeTableModel]?
    
    init(delegate: FlightsDepartureViewModelDelegate,
         interactor: FlightsDepartureViewBoundary,
         dataTransporter: ViewDataTransporter?) {
        self.delegate = delegate
        self.interactor = interactor
        self.dataTransporter = dataTransporter
    }
    
    //MARK: - Getters
    
    var selectedAirport: AirportModel? {
        return dataTransporter?.selectedAirport
    }
    
    var nameAirport: String? {
        return selectedAirport?.nameAirport
    }
    
    //MARK: - User-defined
    
    func retrieveFlightDepartureInformation() {
        interactor?.retriveFlightDepartureTimes(iataCode: selectedAirport?.codeIataAirport ?? "", success: { (error, departureTimeList) in
            if error == nil {
                self.delegate?.refreshList(with: departureTimeList)
            } else {
                self.delegate?.showFailure(with: error)
            }
        }, failure: { (error) in
            self.delegate?.showFailure(with: error)
        })
    }
    
    func retriveStubResponse() {
        do {
            if let filepath = Bundle.main.path(forResource: "AirportDepartureTimetable", ofType: "json") {
                let decoder = JSONDecoder()
                let data = try Data(contentsOf: URL(fileURLWithPath: filepath))
                let list = try decoder.decode([FlightDepartureTimeTableModel].self, from: data)
                self.delegate?.refreshList(with: list)
            } else {
                self.delegate?.refreshList(with: nil)
            }
        } catch {
            print("FlightsDepartureViewModel : \(error.localizedDescription)")
            self.delegate?.refreshList(with: nil)
        }
    }
}
