//
//  HomeViewModel.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import Foundation
import CoreLocation

class HomeViewModel {
    
    let weatherRequest = WeatherRequest()
    var weatherData = WeatherModelData()
    var didHomeViewModelLoad: ((Bool) -> Void)?
    var homeViewModelError: ((Error) -> Void)?
    
    func searchCurrentWeather(for cityName: String) {
        let URLString = "\(Constants.WeatherAPI.kWeatherURL)q=\(cityName)"
        requestWeatherData(with: URLString)
    }
    
    func searchCurrentWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        let URLString = "\(Constants.WeatherAPI.kWeatherURL)lat=\(latitude)&lon=\(longitude)"
        requestWeatherData(with: URLString)
    }
    
    func requestWeatherData(with URLString: String) {
        weatherRequest.performFiveDayWeatherRequest(with: URLString) { result in
            do {
                let newWeather = try result.get()
                
                self.weatherData.cityName = newWeather.cityName
                self.weatherData.conditionName = newWeather.conditionName
                self.weatherData.gust = newWeather.gust
                self.weatherData.humidity = newWeather.humidity
                self.weatherData.minimumTemperature = newWeather.minTemperature
                self.weatherData.maximumTemperature = newWeather.maxTemperature
                self.weatherData.pressure = newWeather.pressure
                self.weatherData.seaLevel = newWeather.seaLevel
                self.weatherData.temperature = newWeather.temperature
                self.weatherData.date = newWeather.date
                self.weatherData.windSpeed = newWeather.wind
                self.weatherData.latitude = newWeather.latitude
                self.weatherData.longitude = newWeather.longitude
                self.requestOneWWeatherCallData(String(newWeather.latitude), String(newWeather.longitude))
            } catch {
                self.homeViewModelError?(error)
            }
        }
    }
    
    func requestOneWWeatherCallData(_ latitude: String, _ longitude: String) {
        let URLString = "\(Constants.WeatherAPI.kOneCallWeatherURL  )&lat=\(latitude)&lon=\(longitude)"
        weatherRequest.performOneCallWeatherRequest(with: URLString) { result in
            do {
                let newOneCallWeather = try result.get()
                self.weatherData.oneCallDate = newOneCallWeather.date
                self.weatherData.maximumTemperatureOfDay = newOneCallWeather.maximumTemperatureOfTheDay
                self.weatherData.minimumTemperatureOfDay = newOneCallWeather.minimumTemperatureOfTheDay
                self.weatherData.moonset = newOneCallWeather.moonset
                self.weatherData.moonrise = newOneCallWeather.moonrise
                self.weatherData.sunset = newOneCallWeather.sunset
                self.weatherData.sunrise = newOneCallWeather.sunrise
                self.didHomeViewModelLoad?(true)
            } catch {
                self.homeViewModelError?(error)
            }
        }
    }
    
    func checkBackGroundImage(_ conditions: String) -> String {
        switch conditions {
        case "Lightning":
            return "CloudBolt"
        case "Drizzle":
            return "CloudDrizzle"
        case "Rain":
            return "CloudRain"
        case "Snow":
            return "CloudSnow"
        case "Fog":
            return "CloudFog"
        case "ClearSky":
            return "ClearSky"
        default:
            return "IconBackground"
        }
    }
    
    func convertTime(_ date: Int) -> String {
         let date = Date(timeIntervalSince1970: Double(date))
         let dateFormatter = DateFormatter()
         dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.timeZone = .current
         return dateFormatter.string(from: date)
    }
    
    func convertDate(_ date: Int) -> String {
         let date = Date(timeIntervalSince1970: Double(date))
         let DateFormate = "yy-MM-dd"
         let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormate
        dateFormatter.timeZone = .current
         return dateFormatter.string(from: date)
    }
}
