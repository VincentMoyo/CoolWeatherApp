//
//  OneCallWeatherViewModel.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/02.
//

import Foundation

struct OneCallWeatherDataModel {
    let date: [Int]
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let maximumTemperatureOfTheDay: [Double]
    let minimumTemperatureOfTheDay: [Double]
    let uvProtection: Double
}
