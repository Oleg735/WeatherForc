//
//  ForecastVController.swift
//  weather16_app
//
//  Created by user on 20.11.2021.
//

import UIKit
import CoreLocation

// custom cell: collection view
// API / request to get the data
class ForecastVController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet var table: UITableView!
//    var models = [DailyWeatherEntry]()
//    var hourlyModels = [HourlyWeatherEntry]()
    private var hourArray = [Hour]()

    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var allPosts: Instruction?
//    var weatherResponse: WeatherResponse?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Register 2 cells
        table.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)

        table.delegate = self
        table.dataSource = self

        table.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        //view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }

    // Location
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if !locations.isEmpty, currentLocation == nil  {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }

    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude

        //let url = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/\(lat),\(long)?exclude=[flags,minutely]"
        let url = "http://api.weatherapi.com/v1/forecast.json?key=5d660d04041a48beb80213202210911&q=\(lat),\(long)&days=1"

        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in

            // Validation
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            // Convert data to models/some object
            //var json: WeatherResponse?
            var json: Instruction?
            do {
                //json = try JSONDecoder().decode(WeatherResponse.self, from: data)
                json = try JSONDecoder().decode(Instruction.self, from: data)

            }
            catch {
                print("error__: \(error)")
            }

            guard let result = json else {
                return
            }

            let entries = result.forecast.forecastday.first?.hour
            //let entries = result.daily.data
            //print("______\(entries)")

            self.hourArray.append(contentsOf: entries!)

            let current = result
            self.allPosts = current
           // self.hourlyModels = result.hourly.data

            // Update user interface
            DispatchQueue.main.async {
                self.table.reloadData()
                
                self.table.tableHeaderView = self.createTableHeader()
            }

        }).resume()
    }

    func createTableHeader() -> UIView {
        let headerVIew = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))

        headerVIew.backgroundColor = UIColor(red: 2/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)

        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width-20, height: headerVIew.frame.size.height/5))
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width-20, height: headerVIew.frame.size.height/5))
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height+summaryLabel.frame.size.height, width: view.frame.size.width-20, height: headerVIew.frame.size.height/2))

        headerVIew.addSubview(locationLabel)
        headerVIew.addSubview(tempLabel)
        headerVIew.addSubview(summaryLabel)

        tempLabel.textAlignment = .center
        locationLabel.textAlignment = .center
        summaryLabel.textAlignment = .center


        guard let currentWeather = self.allPosts else {
            return UIView()
        }

        locationLabel.text = currentWeather.location.name
        locationLabel.font = UIFont(name: "Helvetica-Bold", size: 27)
        tempLabel.text = "\(currentWeather.current.tempC)°"
        tempLabel.font = UIFont(name: "Helvetica-Bold", size: 33)
        summaryLabel.text = self.allPosts?.current.condition.text
        summaryLabel.font = UIFont(name: "Helvetica", size: 23)

        return headerVIew
    }
   


    // Table
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            // 1 cell that is collectiontableviewcell
//            return 1
//        }
        
        //print("models.count____________\(hourArray.count)")
        return  hourArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
//            cell.configure(with: hourlyModels)
//            cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
//            return cell
//        }

       // Continue
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.configure(with: hourArray[indexPath.row])
        cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        return cell
      //  return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}



struct HourlyWeatherEntry: Codable {
//    let time: Int
//    let summary: String
//    let icon: String
//    let precipIntensity: Float
//    let precipProbability: Double
//    let precipType: String?
//    let temperature: Double
//    let apparentTemperature: Double
//    let dewPoint: Double
//    let humidity: Double
//    let pressure: Double
//    let windSpeed: Double
//    let windGust: Double
//    let windBearing: Int
//    let cloudCover: Double
//    let uvIndex: Int
//    let visibility: Double
//    let ozone: Double
}
