//
//  WeatherData.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import Foundation

struct WeatherJSON: Codable{
    let city: City
    let list: [List]
    
    struct City: Codable {
        let name: String
        let coord: Coord
        
        struct Coord: Codable {
            let lat: Double
            let lon: Double
        }
    }
    struct List: Codable {
        let dt: Int
        let main: Main
        let weather: [Weather]
        let wind: Wind
        
        struct Main: Codable {
            let temp: Double
            let temp_min: Double
            let temp_max: Double
            let pressure: Int
            let sea_level: Int
            let humidity: Int
        }
        
        struct Weather: Codable {
            let description : String
            let id: Int
        }
        
        struct Wind: Codable {
            let speed: Double
            let gust: Double
        }
    }
}
