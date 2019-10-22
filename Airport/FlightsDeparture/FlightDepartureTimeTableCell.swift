//
//  FlightDepartureTimeTableCell.swift
//  Airport
//
//  Created by Nilesh Prajapati (ZA) on 2019/10/15.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class FlightDepartureTimeTableCell: UITableViewCell {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblFlightName: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblFlightCode: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    var failureStatusList = ["cancelled", "diverted", "unknown", "redirected", "departed"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func populateCell(with departureInformation: FlightDepartureTimeTableModel?) {
        lblFlightName.text = departureInformation?.airline?.name
        lblFlightCode.text = departureInformation?.flight?.icaoNumber
        lblTime.text = departureInformation?.departure?.scheduledTime?.stringFromDate(inputFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS", outputFormat: "HH:mm")
        lblStatus.text = departureInformation?.status?.capitalized
        if failureStatusList.contains((departureInformation?.status?.lowercased())!) {
            statusImageView.image = UIImage(named: "Red_dot")
        } else {
            statusImageView.image = UIImage(named: "green_dot")
        }
        lblCity.text = "Terminal : \(departureInformation?.departure?.terminal ?? "N/A")"
    }
}
