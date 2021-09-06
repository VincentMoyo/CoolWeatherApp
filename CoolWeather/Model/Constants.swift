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
    struct CellIdentification {
        static let kFiveDaysCollectionView = "FiveDaysCollectionView"
        static let kForecastCollectionView = "ForecastCollectionView"
    }
    struct WeatherConditions {
        static let kLightning = "Lightning"
        static let kDrizzle = "Drizzle"
        static let kRain = "Rain"
        static let kSnow = "Snow"
        static let kFog = "Fog"
        static let kClearSky = "ClearSky"
        static let kNotAvailable = "Not Available"
    }
    struct WeatherIconImages {
        static let kCloudBolt = "CloudBolt"
        static let kCloudDrizzle = "CloudDrizzle"
        static let kCloudRain = "CloudRain"
        static let kCloudSnow = "CloudSnow"
        static let kCloudFog = "CloudFog"
        static let kClearSky = "ClearSky"
        static let kDefault = "IconBackground"
    }
}
