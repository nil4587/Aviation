//
//  FlightsDepartureViewController.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/13.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class FlightsDepartureViewController: BaseViewController {

    @IBOutlet private weak var flightDepartureTableView: UITableView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!

    private lazy var viewModel = FlightsDepartureViewModel(delegate: self,
                                                   interactor: FlightsDepartureViewInteractor(),
                                                   dataTransporter: self.dataTransporter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.nameAirport
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 20.0)
        ]
        self.loadingIndicator.startAnimating()
        viewModel.retrieveFlightDepartureInformation()
        //viewModel.retriveStubResponse()
    }
}

//MARK: - UITableViewDataSource

extension FlightsDepartureViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = viewModel.departureTimeList?.count, count > 0 {
            tableView.backgroundView = nil
           return count
        } else {
            let lblErrorMessage = UILabel()
            lblErrorMessage.frame = tableView.bounds
            lblErrorMessage.textAlignment = .center
            lblErrorMessage.text = "no_record_found".localised()
            tableView.backgroundView = lblErrorMessage
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FlightDepartureTimeTableCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! FlightDepartureTimeTableCell
        cell.populateCell(with: viewModel.departureTimeList?[indexPath.row])
        return cell
    }
}

//MARK: - FlightsDepartureViewModelDelegate

extension FlightsDepartureViewController: FlightsDepartureViewModelDelegate {
    func refreshList(with list: [FlightDepartureTimeTableModel]?) {
        viewModel.departureTimeList = list
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.flightDepartureTableView.reloadData()
        }
    }
    
    func showFailure(with error: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.flightDepartureTableView.reloadData()
            self?.displayAlert(message: error ?? "api_something_went_wrong".localised())
        }
    }
}
