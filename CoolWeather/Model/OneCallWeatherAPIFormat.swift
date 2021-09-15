//
//  OneCallWeatherJSON.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/02.
//

import Foundation

struct OneCallWeatherAPIFormat: Codable {
    
    let daily: [Daily]
    
    struct Daily: Codable {
        let date: Int
        let sunriseTime: Int
        let sunsetTime: Int
        let moonriseTime: Int
        let moonsetTime: Int
        let currentTemperature: Temp
        let uvProtection: Double
        
        private enum CodingKeys: String, CodingKey {
            case date = "dt"
            case sunriseTime = "sunrise"
            case sunsetTime = "sunset"
            case moonriseTime = "moonrise"
            case moonsetTime = "moonset"
            case currentTemperature = "temp"
            case uvProtection = "uvi"
        }
        
        struct Temp: Codable {
            let maximum: Double
            let minimum: Double
            
            private enum CodingKeys: String, CodingKey {
                case maximum = "min"
                case minimum = "max"
            }
        }
    }
}
