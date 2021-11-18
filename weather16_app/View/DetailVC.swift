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
    @IBOutlet weak var ImageViewCity: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempCity: UILabel!

    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var probabilityRain: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    
    var weatherModel: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshLabel()
        
    }
    func setImage(urlName: String){
        guard let imageUrl = URL(string: urlName) else { return }
        ImageViewCity.sd_setImage(with: imageUrl, completed: nil)
    }
    
    func convert(url: String) {
    }

    func load(urlName: String){
        guard let imageUrl = URL(string: urlName) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.ImageViewCity.image = image
                    }
                }
            }
        }
    }

    func refreshLabel() {
        nameCityLabel.text = weatherModel?.name
        setImage(urlName: weatherModel!.icon)
//        print("_______\(weatherModel!.icon)____")
        conditionLabel.text = weatherModel?.text
        tempCity.text =  "\(weatherModel!.temperatureString) ºC"
        maxTemp.text = "\(weatherModel!.maxTemp) ºC"
        minTemp.text = "\(weatherModel!.minTemp) ºC"
        probabilityRain.text = "\(weatherModel!.dailyChanceOfRain) %"
        windSpeed.text = "\(weatherModel!.windKph) km/h"
        
    }


}
