//
//  Constants.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import Foundation

struct Constants {

    struct WeatherAPI {
        static let kWeatherURL = "https://api.openweathermap.org/data/2.5/forecast?units=metric&appid=142b7217f291c1757ed44fd29411e4b3&"
        static let kOneCallWeatherURL = "https://api.openweathermap.org/data/2.5/onecall?appid=142b7217f291c1757ed44fd29411e4b3&units=metric&exclude=hourly"
    }
}
