//
//  MiscWeatherViewModel.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/23.
//

import Foundation

struct MiscWeatherViewModel {
    
     var miscWeatherDataList: [String: String] = [:]
    
    mutating func setMiscWeatherDataList(mistWeatherData: MiscWeatherData) {
        miscWeatherDataList["sunrise"] = mistWeatherData.sunrise
        miscWeatherDataList["sunset"] = mistWeatherData.sunset
        miscWeatherDataList["moonrise"] = mistWeatherData.moonrise
        miscWeatherDataList["moonset"] = mistWeatherData.moonset
        miscWeatherDataList["uvProtection"] = mistWeatherData.uvProtection
        miscWeatherDataList["humidity"] = mistWeatherData.humidity
        miscWeatherDataList["visibility"] = mistWeatherData.visibility
        miscWeatherDataList["pressure"] = mistWeatherData.pressure
        miscWeatherDataList["seaLevel"] = mistWeatherData.seaLevel
        miscWeatherDataList["windspeed"] = mistWeatherData.windspeed
        miscWeatherDataList["windDegree"] = mistWeatherData.windDegree
        miscWeatherDataList["gust"] = mistWeatherData.gust
    }
}
