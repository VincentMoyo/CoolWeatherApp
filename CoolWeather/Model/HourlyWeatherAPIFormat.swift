//
//  WeatherData.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import Foundation

struct HourlyWeatherAPIFormat: Codable {
    let city: City
    let list: [List]
    
    struct City: Codable {
        let cityName: String
        let coordinates: Coord
        
        struct Coord: Codable {
            let latitude: Double
            let longitude: Double
            
            private enum CodingKeys: String, CodingKey {
                case latitude = "lat"
                case longitude = "lon"
            }
        }
        private enum CodingKeys: String, CodingKey {
            case cityName = "name"
            case coordinates = "coord"
        }
    }
    
    struct List: Codable {
        let date: Int
        let main: Main
        let weather: [Weather]
        let wind: Wind
        let visibility: Int
        
        struct Main: Codable {
            let temp: Double
            let temp_min: Double
            let temp_max: Double
            let pressure: Int
            let sea_level: Int
            let humidity: Int
        }
        
        struct Weather: Codable {
            let description: String
            let descriptionID: Int
            
            private enum CodingKeys: String, CodingKey {
                case description
                case descriptionID = "id"
            }
        }
        
        struct Wind: Codable {
            let speed: Double
            let gust: Double
            let degrees: Int
            
            private enum CodingKeys: String, CodingKey {
                case speed
                case gust
                case degrees = "deg"
            }
        }
        private enum CodingKeys: String, CodingKey {
            case date = "dt"
            case main
            case weather
            case visibility
            case wind
        }
    }
}
