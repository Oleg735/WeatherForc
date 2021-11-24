//
//  WeatherTableViewCell.swift
//  weather16_app
//
//  Created by user on 20.11.2021.
//
import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var highTempLabel: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    static let identifier = "WeatherTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell",
                     bundle: nil)
    }

    func configure(with model: Hour) {
        self.highTempLabel.textAlignment = .center
        self.lowTempLabel.textAlignment = .center
        self.lowTempLabel.text = model.condition.text
        self.highTempLabel.text = "\(Int(model.tempCHour))°"
        //self.dayLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.time) ?? 0))
        self.dayLabel.text = model.time
        self.iconImageView.contentMode = .scaleAspectFit

        let icon = model.condition.text
        self.iconImageView.image = UIImage(named: icon)

    }

    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Monday
        return formatter.string(from: inputDate)
    }
    
}
