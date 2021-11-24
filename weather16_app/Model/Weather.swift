//
//  Weather.swift
//  weather16_app
//
//  Created by user on 10.11.2021.
//

import Foundation

struct Weather: Decodable{
    var name: String = ""
    var localtime: String = ""
    var lastUpdated: String = ""
    var temperature: Double = 0.0
    var temperatureString : String {
        return String(format: "%.0f", temperature)
    }
    var text: String = ""
    var icon: String = ""
    var date: String = ""
    var sunrise: String = ""
    var sunset: String = ""
    var feelsLike: Double = 0.0
    var maxTemp: Double = 0.0
    var minTemp: Double = 0.0
    var dailyChanceOfRain: Int = 0
    var avgtempC: Double = 0.0
    var time: String = ""
    var tempHour: Double = 0.0
    var windKph: Double = 0.0
    
    init?(instruction: Instruction) {
        name = instruction.location.name
        localtime = instruction.location.localtime
        lastUpdated = instruction.current.lastUpdated
        temperature = instruction.current.tempC
        text = instruction.current.condition.text
        icon = instruction.current.condition.icon
        feelsLike = instruction.current.feelsLike
        sunrise = instruction.forecast.forecastday.first!.astro.sunrise
        sunset = instruction.forecast.forecastday.first!.astro.sunset
        date = instruction.forecast.forecastday.first!.date
        maxTemp = instruction.forecast.forecastday.first!.day.maxtempC
        minTemp = instruction.forecast.forecastday.first!.day.mintempC
        dailyChanceOfRain = instruction.forecast.forecastday.first!.day.dailyChanceOfRain
        avgtempC = instruction.forecast.forecastday.first!.day.avgtempC
        time = instruction.forecast.forecastday.first!.hour.first!.time
        tempHour = instruction.forecast.forecastday.first!.hour.first!.tempCHour
        windKph = instruction.forecast.forecastday.first!.hour.first!.windKph
    }
    init() {
        
    }
}
