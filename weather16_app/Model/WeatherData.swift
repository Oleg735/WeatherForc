//
//  WeatherData.swift
//  weather16_app
//
//  Created by user on 10.11.2021.
//

import Foundation

struct Instruction: Decodable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

struct Location: Decodable{
    let name: String
    let localtime: String  //"2021-11-10 0:25"
}

struct Current: Decodable {
    let lastUpdated: String
    let tempC: Double
    let feelsLike: Double
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case feelsLike = "feelslike_c"
        case condition
       }
}

struct Condition: Decodable {
    let text: String
    let icon: String
}

struct Forecast: Decodable {
    let forecastday: [Forecastday]
}

// MARK: - Forecastday
struct Forecastday: Decodable {
    let date: String
    let day: Day
    let astro: Astro
    let hour: [Hour]
}

struct Day: Decodable {
    let maxtempC: Double
    let mintempC: Double
    let dailyChanceOfRain: Int
    let avgtempC: Double
    //let maxwindKph: Double
    //let totalprecipMm, totalprecipIn, avgvisKM, avgvisMiles: Int
    //let avghumidity, dailyWillItRain, dailyChanceOfRain, dailyWillItSnow: Int
    let condition: Condition

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case avgtempC = "avgtemp_c"
        case condition
    }
}

struct Astro: Decodable {
    let sunrise: String
    let sunset: String
}

struct Hour: Decodable {
    let time: String
    let tempCHour: Double
    //let isDay: Int
    let condition: Condition
    let windKph: Double
//    let pressureMB: Int
//    let pressureIn: Double
//    let precipMm, precipIn, humidity, cloud: Int
    let feelslikeC,  windchillC: Double
//    let willItRain, chanceOfRain, willItSnow, chanceOfSnow: Int

    enum CodingKeys: String, CodingKey {
           case time
           case tempCHour = "temp_c"
//           case isDay = "is_day"
           case condition
           case windKph = "wind_kph"
//           case pressureMB = "pressure_mb"
//           case pressureIn = "pressure_in"
//           case precipMm = "precip_mm"
//           case precipIn = "precip_in"
//           case humidity, cloud
           case feelslikeC = "feelslike_c"
           case windchillC = "windchill_c"
//           case willItRain = "will_it_rain"
//           case chanceOfRain = "chance_of_rain"
//           case willItSnow = "will_it_snow"
//           case chanceOfSnow = "chance_of_snow"
       }
}
