//
//  MiscWeatherInfoCollectionViewModel.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/26.
//

import Foundation

struct MiscWeatherInfoCollectionViewModel {
    
    func backGroundImagesName(todayWeatherCondition: Icon) -> String {
        switch todayWeatherCondition {
        case .windspeed:
            return "wind"
        case .pressure:
            return "seal"
        case .windDegree:
            return "location.north.line"
        case .seaLevel:
            return "wake"
        case .sunrise:
            return "sunrise"
        case .sunset:
            return "sunset"
        case .moonrise:
            return "moon"
        case .moonset:
            return "moon.zzz"
        case .visibility:
            return "cloud.fog"
        case .humidity:
            return "lasso"
        case .uvProtection:
            return "cloud.rain"
        case .gust:
            return "wind.snow"
        }
    }
}
