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
}

extension HourlyWeatherAPIFormat {
    
    struct City: Codable {
        let cityName: String
        let coordinates: Coord
        
        private enum CodingKeys: String, CodingKey {
            case cityName = "name"
            case coordinates = "coord"
        }
    }
}

extension HourlyWeatherAPIFormat {
    
    struct List: Codable {
        let date: Int
        let main: Main
        let weather: [Weather]
        let wind: Wind
        let visibility: Int
        
        private enum CodingKeys: String, CodingKey {
            case date = "dt"
            case main
            case weather
            case visibility
            case wind
        }
    }
}

extension HourlyWeatherAPIFormat {
    
    struct Coord: Codable {
        let latitude: Double
        let longitude: Double
        
        private enum CodingKeys: String, CodingKey {
            case latitude = "lat"
            case longitude = "lon"
        }
    }
}

extension HourlyWeatherAPIFormat {
    
    struct Weather: Codable {
        let description: String
        let descriptionID: Int
        
        private enum CodingKeys: String, CodingKey {
            case description
            case descriptionID = "id"
        }
    }
}

extension HourlyWeatherAPIFormat {
    
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
}

extension HourlyWeatherAPIFormat {
    
    struct Main: Codable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let sea_level: Int
        let humidity: Int
    }
}
