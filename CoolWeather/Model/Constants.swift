//
//  Constants.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import Foundation

struct Constants {
    
    static let kDateFormat = "EEEE"
    static let kMiscellaneousIdentifier = "goToMiscellaneous"
    static let kUserLocations = "UserLocations"
    
    struct WeatherAPI {
        static let kWeatherURL = "https://api.openweathermap.org/data/2.5/forecast?units=metric&appid=142b7217f291c1757ed44fd29411e4b3&"
        static let kOneCallWeatherURL = "https://api.openweathermap.org/data/2.5/onecall?appid=142b7217f291c1757ed44fd29411e4b3&units=metric&exclude=hourly"
        static let kURLString = "https://api.openweathermap.org/data/2.5/forecast?units=metric&appid=142b7217f291c1757ed44fd29411e4b3&q=benoni"
        
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
    struct WeatherSymbols {
        static let kCelsiusSymbol = " ° C"
        static let kHumiditySymbol = "%"
        static let kPressureSymbol = " hPa"
        static let kVisibilitySymbol = " km"
        static let kSpeedSymbol = " km/hr"
        static let kDegreeSymbol = "°"
        static let kSeaLevelSymbol = " m"
    }
    struct AlertButtonTexts {
        static let kSearch = "Search"
        static let kDelete = "Delete"
        static let kPlaceholder = "Please a city"
    }
    struct miscWeatherList {
        static let kSunrise = "sunrise"
        static let kSunset = "sunset"
        static let kMoonrise = "moonrise"
        static let kMoonset = "moonset"
        static let kUvProtection = "uvProtection"
        static let kHumidity = "humidity"
        static let kVisibility = "visibility"
        static let kPressure = "pressure"
        static let kSeaLevel = "seaLevel"
        static let kWindspeed = "windspeed"
        static let kWindDegree = "windDegree"
        static let kGust = "gust"
    }
}
