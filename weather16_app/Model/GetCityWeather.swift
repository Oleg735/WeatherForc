//
//  GetCityWeather.swift
//  weather16_app
//
//  Created by user on 10.11.2021.
//

import Foundation
import CoreLocation

let networkWeatherManeger = NetworkWeatherManeger()

func getCityWeather(citiesArray: [String], complitionHendler: @escaping (Int, Weather) -> Void) {
    for (index, item) in citiesArray.enumerated() {
        getCoordinateFrom(city: item) { (coordinate, error) in
            guard let coordinate = coordinate, error == nil else { return }

            networkWeatherManeger.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { (weather) in
                complitionHendler(index, weather)
            }
        }
    }
}

func getCoordinateFrom(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ){
    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
     //   print(" AAAAA___ \(placemark?.first?.location?.coordinate)")
        completion(placemark?.first?.location?.coordinate, error)
    }
}
