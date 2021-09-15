//
//  HomeViewModel.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import Foundation
import CoreLocation

class WeatherViewModel {
    
    let locationManager = CLLocationManager()
    private static let dateFormatter = DateFormatter()
    
    private let weatherRequest = WeatherRequest()
    private var weather: HourlyWeatherDataModel?
    private var oneCallAPI: OneCallWeatherDataModel?
    var didHomeViewModelLoad: ((Bool) -> Void)?
    var homeViewModelError: ((Error) -> Void)?
    
    func searchCurrentWeather(for cityName: String) {
        let URLString = "\(Constants.WeatherAPI.kWeatherURL)q=\(cityName)"
        requestWeatherData(with: URLString)
    }
    
    private var todayWeatherCondition: WeatherCondition? {
        guard let condition = weather?.conditionName.first else { return nil }
        return WeatherCondition(rawValue: condition)
    }
    
    func appendCelsiusSymbol() -> String {
        " ° C"
    }
    
    func backGroundImagesName() -> String {
        switch todayWeatherCondition {
        case .lightning:
            return Constants.WeatherIconImages.kCloudBolt
        case .drizzle:
            return Constants.WeatherIconImages.kCloudDrizzle
        case .rain:
            return Constants.WeatherIconImages.kCloudRain
        case .snow:
            return Constants.WeatherIconImages.kCloudSnow
        case .fog:
            return Constants.WeatherIconImages.kCloudFog
        case .clearSky:
            return Constants.WeatherIconImages.kClearSky
        default:
            return Constants.WeatherIconImages.kDefault
        }
    }
    
    func searchCurrentWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        let URLString = "\(Constants.WeatherAPI.kWeatherURL)lat=\(latitude)&lon=\(longitude)"
        requestWeatherData(with: URLString)
    }
    
    private func requestWeatherData(with URLString: String) {
        weatherRequest.performFiveDayWeatherRequest(with: URLString) { result in
            do {
                let newWeather = try result.get()
                self.weather = newWeather
                self.requestOneWWeatherCallData(String(newWeather.latitude), String(newWeather.longitude))
            } catch {
                self.homeViewModelError?(error)
            }
        }
    }
    
    private func requestOneWWeatherCallData(_ latitude: String, _ longitude: String) {
        let URLString = "\(Constants.WeatherAPI.kOneCallWeatherURL  )&lat=\(latitude)&lon=\(longitude)"
        weatherRequest.performOneCallWeatherRequest(with: URLString) { result in
            do {
                let newOneCallWeather = try result.get()
                self.oneCallAPI = newOneCallWeather
                self.didHomeViewModelLoad?(true)
            } catch {
                self.homeViewModelError?(error)
            }
        }
    }
    
    func formattedShortStyleTime(for date: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: Double(date))
        WeatherViewModel.dateFormatter.timeStyle = DateFormatter.Style.short
        WeatherViewModel.dateFormatter.timeZone = .current
        return WeatherViewModel.dateFormatter.string(from: date)
    }
    
    func formattedCurrentStyleDate(for date: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: Double(date))
        let dateFormate = Constants.kDateFormat
        WeatherViewModel.dateFormatter.dateFormat = dateFormate
        WeatherViewModel.dateFormatter.timeZone = .current
        return WeatherViewModel.dateFormatter.string(from: date)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            searchCurrentWeather(lat, lon)
        }
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    var cityName: String {
        weather?.cityName ?? ""
    }
    var conditionId: [Int] {
        weather?.conditionId ?? [1]
    }
    var conditionName: [String] {
        weather?.conditionName ?? ["", ""]
    }
    var gust: Double {
        weather?.gust ?? 1.1
    }
    var humidity: Int {
        weather?.humidity ?? 1
    }
    var latitude: Double {
        weather?.latitude ?? 1.1
    }
    var longitude: Double {
        weather?.longitude ?? 1.1
    }
    var seaLevel: Int {
        weather?.seaLevel ?? 1
    }
    var maxTemperature: Int {
        weather?.maxTemperature ?? 1
    }
    var minTemperature: Int {
        weather?.minTemperature ?? 1
    }
    var pressure: Int {
        weather?.pressure ?? 1
    }
    var temperature: [Int] {
        weather?.temperature ?? [1]
    }
    var visibility: Int {
        weather?.visibility ?? 1
    }
    var wind: Double {
        weather?.wind ?? 1.1
    }
    var windSpeedDegree: Int {
        weather?.windSpeedDegree ?? 1
    }
    var date: [Int] {
        weather?.date ?? [1]
    }
    var windSpeed: Double {
        weather?.wind ?? 1.1
    }
    
    var oneCallDates: [Int] {
        oneCallAPI?.date ?? [1]
    }
    var sunrise: Int {
        oneCallAPI?.sunrise ?? 1
    }
    var sunset: Int {
        oneCallAPI?.sunset ?? 1
    }
    var moonrise: Int {
        oneCallAPI?.moonrise ?? 1
    }
    var moonset: Int {
        oneCallAPI?.moonset ?? 1
    }
    var maximumTemperatureOfTheDay: [Int] {
        oneCallAPI?.maximumTemperatureOfTheDay ?? [1]
    }
    var minimumTemperatureOfTheDay: [Int] {
        oneCallAPI?.minimumTemperatureOfTheDay ?? [1]
    }
    var uvProtection: Double {
        oneCallAPI?.uvProtection ?? 1.1
    }
}

enum WeatherCondition: String {
    case lightning = "Lightning"
    case clearSky = "ClearSky"
    case drizzle = "Drizzle"
    case rain = "Rain"
    case fog = "Fog"
    case snow = "Snow"
    case notAvailable = "Not Available" 
}
