//
//  WeatherViewModel.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import Foundation

struct HourlyWeatherDataModel {
    let conditionId: [Int]
    let cityName: String
    let temperature: [Int]
    let date: [Int]
    let minTemperature: Int
    let maxTemperature: Int
    let humidity: Int
    let wind: Double
    let pressure: Int
    let gust: Double
    let seaLevel: Int
    var conditionName: [String]
    let latitude: Double
    let longitude: Double
    let visibility: Int
    let windSpeedDegree: Int
}
