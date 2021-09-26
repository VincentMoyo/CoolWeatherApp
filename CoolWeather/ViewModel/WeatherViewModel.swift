//
//  HomeViewModel.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import Foundation
import CoreLocation

enum WeatherCondition: String {
    case lightning = "Lightning"
    case clearSky = "ClearSky"
    case drizzle = "Drizzle"
    case rain = "Rain"
    case fog = "Fog"
    case snow = "Snow"
    case notAvailable = "Not Available"
}

class WeatherViewModel {
    
    private lazy var dateFormatter = DateFormatter()
    let locationManager = CLLocationManager()
    private let defaults = UserDefaults.standard
    var userLocations = [""]
    private var weather: HourlyWeatherDataModel?
    private var oneCallAPI: OneCallWeatherDataModel?
    
    private var weatherRepository: WeatherViewModelRepository
    var modelLoad: ((Bool) -> Void)?
    var modelError: ((Error) -> Void)?
    
    init(weatherRepository: WeatherViewModelRepository = WeatherViewModelRepository()) {
        self.weatherRepository = weatherRepository
    }
    
    func bindRepository() {
        weatherRepository.repositoryLoad = { result in
            if result {
                self.weather = self.weatherRepository.weather
                self.oneCallAPI = self.weatherRepository.oneCallAPI
                self.modelLoad?(true)
            }
        }
    }
    
    func searchCurrentWeather(for cityName: String) {
        weatherRepository.searchCurrentWeather(for: cityName)
        bindRepository()
    }
    
    func searchCurrentWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        weatherRepository.searchCurrentWeather(latitude, longitude)
        bindRepository()
    }
    
    // MARK: - Weather Variables
    
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
    
    var maxTemperature: String {
        Measurement(value: Double(weather?.maxTemperature ?? 0), unit: UnitTemperature.celsius).description
    }
    
    var minTemperature: String {
        Measurement(value: Double(weather?.minTemperature ?? 0), unit: UnitTemperature.celsius).description
    }
    
    var pressure: Int {
        weather?.pressure ?? 1
    }
    
    var temperature: [Int] {
        weather?.temperature ?? []
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
    
    var sunrise: String {
        formattedShortStyleTime(for: TimeInterval(oneCallAPI?.sunrise ?? 1))
    }
    
    var sunset: String {
        formattedShortStyleTime(for: TimeInterval(oneCallAPI?.sunset ?? 1))
    }
    
    var moonrise: String {
        formattedShortStyleTime(for: TimeInterval(oneCallAPI?.moonrise ?? 1))
    }
    
    var moonset: String {
        formattedShortStyleTime(for: TimeInterval(oneCallAPI?.moonset ?? 1))
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
    
    func getInfo() -> MiscWeatherData {
        return MiscWeatherData(windspeed: String(windSpeed),
                                                 gust: String(gust),
                                                 windDegree: String(windSpeedDegree),
                                                 seaLevel: String(seaLevel),
                                                 sunrise: String(sunrise),
                                                 sunset: sunset,
                                                 moonrise: moonrise,
                                                 moonset: moonset,
                                                 pressure: String(pressure),
                                                 visibility: String(visibility),
                                                 humidity: String(humidity),
                                                 uvProtection: String(uvProtection))
    }
    
    private var todayWeatherCondition: WeatherCondition? {
        guard let condition = weather?.conditionName.first else { return nil }
        return WeatherCondition(rawValue: condition)
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
    
    // MARK: - Location Manager
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherRepository.searchCurrentWeather(lat, lon)
            bindRepository()
        }
    }
    
    // MARK: - User Defaults
    
    func loadUserLocationsFromUserDefaults() {
        if let items = defaults.array(forKey: Constants.kUserLocations) as? [String] {
            userLocations = items
            menu.dataSource = items
        }
    }
    
    func updateUserDefaults() {
        defaults.setValue(userLocations, forKey: Constants.kUserLocations)
        menu.dataSource = userLocations
    }
    
    func addCityToUserDefault(_ city: String) {
        if userLocations.contains(city) == false {
            userLocations.append(city)
        }
    }
    
    // MARK: - Conversion of unix UTC to time
    
    private func formattedShortStyleTime(for date: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: Double(date))
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    private func formattedCurrentStyleDate(for date: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: Double(date))
        let dateFormate = Constants.kDateFormat
        dateFormatter.dateFormat = dateFormate
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    func UTCDateConvertedToDateFrom(index dateIndex: Int) -> String? {
        guard let selectedDate = weather?.date else {return ""}
        return formattedCurrentStyleDate(for: TimeInterval(selectedDate [safe: dateIndex]!))
    }
    
    func UNTCTimeConvertedToTimeFrom(index timeIndex: Int) -> String? {
        guard let selectedTime = weather?.date else {return ""}
        return formattedShortStyleTime(for: TimeInterval(selectedTime [safe: timeIndex]!))
    }
    
    func convertIntToTemperature(_ temperature: Int) -> String {
        let measurement = Measurement(value: Double(temperature), unit: UnitTemperature.celsius)
        return measurement.description
    }
}

extension WeatherViewModel {
    
    func temperature(at index: Int) -> String? {
        guard let temperature = weather?.temperature else {return ""}
        let measurement = Measurement(value: Double(temperature[safe: index]!), unit: UnitTemperature.celsius)
        return measurement.description
    }
    
    func minimumTemperatureAtDate(at index: Int) -> String? {
        guard let temperature = oneCallAPI?.minimumTemperatureOfTheDay else {return ""}
        let measurement = Measurement(value: Double(temperature[safe: index]!), unit: UnitTemperature.celsius)
        return measurement.description
    }
    
    func maximumTemperatureAtDate(at index: Int) -> String? {
        guard let temperature = oneCallAPI?.maximumTemperatureOfTheDay else {return ""}
        let measurement = Measurement(value: Double(temperature[safe: index]!), unit: UnitTemperature.celsius)
        return measurement.description
    }
    
    func conditionNameAtDate(at index: Int) -> String? {
        guard let temperature = weather?.conditionName else {return "notAvailable"}
        return temperature[safe: index]
    }
}
