//
//  WeatherViewModel.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import Foundation

struct WeatherViewModel {
    let conditionId: [Int]
    let cityName: String
    let temperature: [Double]
    let date: [Int]
    let minTemperature: Double
    let maxTemperature: Double
    let humidity: Int
    let wind: Double
    let pressure: Int
    let gust: Double
    let seaLevel: Int
    var conditionName: [String]
    let latitude: Double
    let longitude: Double

    //    var temperatureString: String {
    //        return String(format: "%.1f", temperature)
    //    }
}


