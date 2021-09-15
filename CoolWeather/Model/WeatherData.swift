//
//  RetrievedWeatherData.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import Foundation

struct WeatherData {
    var initialConditionName: [String]
    var initialCityName: String
    var initialTemperature: [Double]
    var initialDate: [Int]
    var initialMaximumTemperature: Double
    var initialMinimumTemperature: Double
    var initialSeaLevel: Int
    var initialHumidity: Int
    var initialWindSpeed: Double
    var initialPressure: Int
    var initialGust: Double
    var initialLatitude: Double
    var initialLongitude: Double
    var initialOneCallWeatherDate: [Int]
    var initialMaximumTemperatureOfTheDay: [Double]
    var initialMinimumTemperatureOfTheDay: [Double]
    var initialSunset: Int
    var initialSunrise: Int
    var initialMoonset: Int
    var initialMoonrise: Int
    var initialUvProtection: Double
    var initialVisibility: Int
    var initialWindSpeedDegree: Int
}
