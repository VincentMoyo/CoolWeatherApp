//
//  WeatherViewModelRepository.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/22.
//

import Foundation
import CoreLocation

class WeatherViewModelRepository {
    
    private let weatherRequest = WeatherRequest()
    var weather: HourlyWeatherDataModel?
    var oneCallAPI: OneCallWeatherDataModel?
    var repositoryLoad: ((Bool) -> Void)?
    var repositoryError: ((Error) -> Void)?
    
    // MARK: - Weather Functions
    func searchCurrentWeather(for cityName: String) {
        weatherRequest.performFiveDayWeatherRequest(for: cityName) { result in
            do {
                let newWeather = try result.get()
                self.weather = newWeather
                self.requestOneWWeatherCallData(newWeather.latitude, newWeather.longitude)
            } catch {
                self.repositoryError?(error)
            }
        }
    }
    
    func searchCurrentWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        weatherRequest.performFiveDayWeatherRequestLat(with: latitude, and: longitude) { result in
            do {
                let newWeather = try result.get()
                self.weather = newWeather
                self.requestOneWWeatherCallData(newWeather.latitude, newWeather.longitude)
            } catch {
                self.repositoryError?(error)
            }
        }
    }
    
    private func requestOneWWeatherCallData(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        weatherRequest.performOneCallWeatherRequest(with: latitude, and: latitude) { result in
            do {
                let newOneCallWeather = try result.get()
                self.oneCallAPI = newOneCallWeather
                self.repositoryLoad?(true)
            } catch {
                self.repositoryError?(error)
            }
        }
    }
    
    func performURLSession(for session: URLSession, completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?units=metric&appid=142b7217f291c1757ed44fd29411e4b3&q=benoni") {
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
}
