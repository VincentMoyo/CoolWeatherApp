//
//  WeatherViewModelRepository.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/22.
//

import Foundation
import CoreLocation

class WeatherRepository: WeatherRepositoryProtocol {
    
    var weather: HourlyWeatherDataModel?
    private let weatherRequest = WeatherRequest()
      var repositoryLoad: ((Bool) -> Void)?
    
    // MARK: - Weather Functions
    
    func searchCurrentWeather(for cityName: String, completion: @escaping (Result<(OneCallWeatherDataModel,HourlyWeatherDataModel), Error>) -> Void) {
        weatherRequest.performFiveDayWeatherRequest(for: cityName) { result in
            do {
                let hourlyWeather = try result.get()
                self.requestOneWWeatherCallData(hourlyWeather.latitude, hourlyWeather.longitude) { resultOneCall in
                    do {
                        let OneCallWeather = try resultOneCall.get()
                        completion(.success((OneCallWeather,hourlyWeather)))
                    } catch {
                        completion(.failure(error))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func searchCurrentWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees, completion: @escaping (Result<(OneCallWeatherDataModel,HourlyWeatherDataModel), Error>) -> Void) {
        weatherRequest.performFiveDayWeatherRequestLat(with: latitude, and: longitude) { result in
            do {
                let hourlyWeather = try result.get()
                self.requestOneWWeatherCallData(hourlyWeather.latitude, hourlyWeather.longitude) { resultOneCall in
                    do {
                        let OneCallWeather = try resultOneCall.get()
                        completion(.success((OneCallWeather,hourlyWeather)))
                    } catch {
                        completion(.failure(error))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func requestOneWWeatherCallData(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees, completion: @escaping (Result<OneCallWeatherDataModel, Error>) -> Void) {
        weatherRequest.performOneCallWeatherRequest(with: latitude, and: latitude) { result in
            do {
                let newOneCallWeather = try result.get()
                self.repositoryLoad?(true)
                completion(.success(newOneCallWeather))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
