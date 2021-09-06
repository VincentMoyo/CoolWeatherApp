//
//  OneCallWeatherJSON.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/02.
//

import Foundation

struct OneCallWeatherJSON: Codable {
    
    let daily: [Daily]
    
    struct Daily: Codable {
        let dt: Int
        let sunrise: Int
        let sunset: Int
        let moonrise: Int
        let moonset: Int
        let temp: Temp
        let uvi: Double
        
        struct Temp: Codable {
            let min: Double
            let max: Double
        }
    }
}
