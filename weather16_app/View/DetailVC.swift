//
//  DetailVC.swift
//  weather16_app
//
//  Created by user on 16.11.2021.
//

import UIKit
import SDWebImage

class DetailVC: UIViewController {

    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var localTime: UILabel!
    @IBOutlet weak var ImageViewCity: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempCity: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!

    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var probabilityRain: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var avgtemp: UILabel!

    
    var weatherModel: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshLabel()
        
    }
//    func setImage(urlName: String){
//        guard let imageUrl = URL(string: urlName) else { return }
//        ImageViewCity.sd_setImage(with: imageUrl, completed: nil)
//    }
//
//    func convert(url: String) {
//    }
//
//    func load(urlName: String){
//        guard let imageUrl = URL(string: urlName) else { return }
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: imageUrl) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self.ImageViewCity.image = image
//                    }
//                }
//            }
//        }
//    }

    func refreshLabel() {
        nameCityLabel.text = weatherModel?.name
        let str = weatherModel!.localtime
        localTime.text = str[10..<20]
        //setImage(urlName: weatherModel!.icon)
        let icon = weatherModel!.text
        ImageViewCity.image = UIImage(named: icon)
        conditionLabel.text = weatherModel?.text
        sunrise.text = weatherModel?.sunrise
        sunset.text = weatherModel?.sunset
        feelsLike.text = "\(weatherModel!.feelsLike)"
        tempCity.text =  "\(weatherModel!.temperatureString) ºC"
        maxTemp.text = "\(weatherModel!.maxTemp) ºC"
        minTemp.text = "\(weatherModel!.minTemp) ºC"
        avgtemp.text = "\(weatherModel!.avgtempC) ºC"
        probabilityRain.text = "\(weatherModel!.dailyChanceOfRain) %"
        windSpeed.text = "\(weatherModel!.windKph) km/h"
        
    }


}
extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
