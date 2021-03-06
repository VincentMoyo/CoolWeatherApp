//
//  WeatherManager.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import Foundation
import CoreLocation
import UIKit

struct WeatherRequest: WeatherRequestProtocol {
    
    var delegateError: ErrorReporting?

    func URLOneCallAPIBuilder(for latitude: CLLocationDegrees, and longitude: CLLocationDegrees) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/onecall"
        let latitudeQueryItem = URLQueryItem(name: "lat", value: String(latitude))
        let longitudeQueryItem = URLQueryItem(name: "lon", value: String(longitude))
        let excludeQueryItem = URLQueryItem(name: "exclude", value: "hourly")
        let unitsQueryItem = URLQueryItem(name: "units", value: "metric")
        let appIDQueryItem = URLQueryItem(name: "appid", value: "142b7217f291c1757ed44fd29411e4b3")
        components.queryItems = [latitudeQueryItem, longitudeQueryItem, excludeQueryItem, unitsQueryItem, appIDQueryItem]
        
        return components.url
    }
    
    func hourlyWeatherAPIURLBuilder(for query: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/forecast"
        let cityNameQueryItem = URLQueryItem(name: "q", value: query)
        let unitsQueryItem = URLQueryItem(name: "units", value: "metric")
        let appIDQueryItem = URLQueryItem(name: "appid", value: "142b7217f291c1757ed44fd29411e4b3")
        components.queryItems = [cityNameQueryItem, unitsQueryItem, appIDQueryItem]
        
        return components.url
    }
    
    func hourlyWeatherAPIURLBuilderLat(for latitude: CLLocationDegrees, and longitude: CLLocationDegrees) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/forecast"
        let latitudeQueryItem = URLQueryItem(name: "lat", value: String(latitude))
        let longitudeQueryItem = URLQueryItem(name: "lon", value: String(longitude))
        let unitsQueryItem = URLQueryItem(name: "units", value: "metric")
        let appIDQueryItem = URLQueryItem(name: "appid", value: "142b7217f291c1757ed44fd29411e4b3")
        components.queryItems = [latitudeQueryItem, longitudeQueryItem, unitsQueryItem, appIDQueryItem]
        
        return components.url
    }
    

    
    func performFiveDayWeatherRequest(for city: String, completion: @escaping (Result<HourlyWeatherDataModel, Error>) -> Void) {
        if let url = hourlyWeatherAPIURLBuilder(for: city) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    completion(.failure(error!))
                    return
                }
                if let safeData = data {
                    if let weather = self.parseFiveDayWeatherJSON(safeData) {
                        completion(.success(weather))
                    }
                }
            }
            task.resume()
        }
    }
    
    func performFiveDayWeatherRequestLat(with latitude: CLLocationDegrees, and longitude: CLLocationDegrees, completion: @escaping (Result<HourlyWeatherDataModel, Error>) -> Void) {
        if let url = hourlyWeatherAPIURLBuilderLat(for: latitude, and: longitude) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    completion(.failure(error!))
                    return
                }
                if let safeData = data {
                    if let weather = self.parseFiveDayWeatherJSON(safeData) {
                        completion(.success(weather))
                    }
                }
            }
            task.resume()
        }
    }
    
    func performOneCallWeatherRequest(with latitude: CLLocationDegrees, and longitude: CLLocationDegrees, completion: @escaping (Result<OneCallWeatherDataModel, Error>) -> Void) {
        if let url = URLOneCallAPIBuilder(for: latitude, and: longitude) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, error) in
                if error != nil {
                    completion(.failure(error!))
                    return
                }
                if let safeData = data {
                    if let weather = self.parseOneCallWeatherJSON(safeData) {
                        completion(.success(weather))
                    }
                }
            }
            task.resume()
        }
    }
    
    func performURLSession(for session: URLSession, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: Constants.WeatherAPI.kURLString) {
        let task = session.dataTask(with: url) { (data, _, error) in
            if error != nil {
                completion(.failure(error!))
                return
            }
            if let safeData = data {
                completion(.success(safeData))
            }
        }
        task.resume()
        }
    }
    
    private func parseOneCallWeatherJSON(_ weatherData: Data) -> OneCallWeatherDataModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(OneCallWeatherAPIFormat.self, from: weatherData)
            let sunrise = decodedData.daily[0].sunriseTime
            let sunset = decodedData.daily[0].sunsetTime
            let moonrise = decodedData.daily[0].moonriseTime
            let moonset = decodedData.daily[0].moonsetTime
            let uvProtection = decodedData.daily[0].uvProtection
            var maximumTemperature: [Int] = []
            var minimumTemperature: [Int] = []
            var date: [Int] = []
            
            for count in 0..<decodedData.daily.count {
                date.append(decodedData.daily[count].date)
            }
            for count in 0..<decodedData.daily.count {
                maximumTemperature.append(Int(decodedData.daily[count].currentTemperature.maximum))
            }
            for count in 0..<decodedData.daily.count {
                minimumTemperature.append(Int(decodedData.daily[count].currentTemperature.minimum))
            }
            
            let weather = OneCallWeatherDataModel(date: date,
                                                  sunrise: sunrise,
                                                  sunset: sunset,
                                                  moonrise: moonrise,
                                                  moonset: moonset,
                                                  maximumTemperatureOfTheDay: maximumTemperature,
                                                  minimumTemperatureOfTheDay: minimumTemperature,
                                                  uvProtection: uvProtection)
            
            return weather
        } catch {
            delegateError?.showUserErrorMessageDidInitiate(NSLocalizedString("WEATHER_API_ERROR", comment: "") + "\(error)")
            return nil
        }
    }
    
    func parseFiveDayWeatherJSON(_ weatherData: Data) -> HourlyWeatherDataModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(HourlyWeatherAPIFormat.self, from: weatherData)
            let newHumidity = decodedData.list[0].main.humidity
            let seaLevel = decodedData.list[0].main.sea_level
            let pressure = decodedData.list[0].main.pressure
            let windSpeed = decodedData.list[0].wind.speed
            let gust = decodedData.list[0].wind.gust
            let latitude = decodedData.city.coordinates.latitude
            let longitude = decodedData.city.coordinates.longitude
            let name = decodedData.city.cityName
            let minTemp = decodedData.list[0].main.temp_min
            let maxTemp = decodedData.list[0].main.temp_max
            let visibility = decodedData.list[0].visibility
            let windDegree = decodedData.list[0].wind.degrees
            var conditionName: [String] = []
            var temperature: [Int] = []
            var date: [Int] = []
            var tempMaxMin: [Double: Double] = [:]
            var id: [Int] = []
            
            for count in 0..<decodedData.list.count {
                id.append(decodedData.list[count].weather[0].descriptionID)
                conditionName.append(checkConditionId(decodedData.list[count].weather[0].descriptionID))
            }
            
            for count in 0..<decodedData.list.count {
                temperature.append(Int(decodedData.list[count].main.temp))
            }
            
            for count in 0..<decodedData.list.count {
                date.append(decodedData.list[count].date)
            }
            
            for count in 0..<decodedData.list.count {
                tempMaxMin[decodedData.list[count].main.temp_min] = decodedData.list[count].main.temp_max
            }
            
            let weather = HourlyWeatherDataModel(conditionId: id,
                                                 cityName: name,
                                                 temperature: temperature,
                                                 date: date,
                                                 minTemperature: Int(minTemp),
                                                 maxTemperature: Int(maxTemp),
                                                 humidity: newHumidity,
                                                 wind: windSpeed,
                                                 pressure: pressure,
                                                 gust: gust,
                                                 seaLevel: seaLevel,
                                                 conditionName: conditionName,
                                                 latitude: latitude,
                                                 longitude: longitude,
                                                 visibility: visibility,
                                                 windSpeedDegree: windDegree)
            return weather
        } catch {
            delegateError?.showUserErrorMessageDidInitiate(NSLocalizedString("WEATHER_API_ERROR", comment: "") + "\(error)")
            return nil
        }
    }
    
    func checkConditionId(_ id: Int) -> String {
        switch id {
        case 200...232:
            return Constants.WeatherConditions.kLightning
        case 300...321:
            return Constants.WeatherConditions.kDrizzle
        case 500...531:
            return Constants.WeatherConditions.kRain
        case 600...622:
            return Constants.WeatherConditions.kSnow
        case 701...781:
            return Constants.WeatherConditions.kFog
        case 800:
            return Constants.WeatherConditions.kClearSky
        case 801...804:
            return Constants.WeatherConditions.kLightning
        default:
            return Constants.WeatherConditions.kNotAvailable
        }
    }
}
