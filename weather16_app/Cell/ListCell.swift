//
//  ListCell.swift
//  weather16_app
//
//  Created by user on 14.11.2021.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var conditionCityLabel: UILabel!
    @IBOutlet weak var tempCityLabel: UILabel!
    
    func configure(instruction: Weather) {
        self.nameCityLabel.text = instruction.name
        self.conditionCityLabel.text = instruction.text
        self.tempCityLabel.text = "\(instruction.temperatureString) ºC"
    }
}
