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
        miscWeatherDataList[Constants.miscWeatherList.kSunrise] = mistWeatherData.sunrise
        miscWeatherDataList[Constants.miscWeatherList.kSunset] = mistWeatherData.sunset
        miscWeatherDataList[Constants.miscWeatherList.kMoonrise] = mistWeatherData.moonrise
        miscWeatherDataList[Constants.miscWeatherList.kMoonset] = mistWeatherData.moonset
        miscWeatherDataList[Constants.miscWeatherList.kUvProtection] = mistWeatherData.uvProtection
        miscWeatherDataList[Constants.miscWeatherList.kHumidity] = mistWeatherData.humidity
        miscWeatherDataList[Constants.miscWeatherList.kVisibility] = mistWeatherData.visibility
        miscWeatherDataList[Constants.miscWeatherList.kPressure] = mistWeatherData.pressure
        miscWeatherDataList[Constants.miscWeatherList.kSeaLevel] = mistWeatherData.seaLevel
        miscWeatherDataList[Constants.miscWeatherList.kWindspeed] = mistWeatherData.windspeed
        miscWeatherDataList[Constants.miscWeatherList.kWindDegree] = mistWeatherData.windDegree
        miscWeatherDataList[Constants.miscWeatherList.kGust] = mistWeatherData.gust
    }
}
