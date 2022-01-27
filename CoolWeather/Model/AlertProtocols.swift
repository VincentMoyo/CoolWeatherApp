//
//  AlertProtocols.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/06.
//

import Foundation
import CoreLocation

protocol ErrorReporting: AnyObject {
    func showUserErrorMessageDidInitiate(_ message: String)
}

protocol HourlyAPI {
    typealias Handler = (Result<HourlyWeatherDataModel, Error>) -> Void
    func requestWeather(from url: URL, then handler: @escaping Handler)
}

protocol WeatherRepositoryProtocol {
    var weather: HourlyWeatherDataModel? { get set }
    var repositoryLoad: ((Bool) -> Void)? { get set }
    
    func searchCurrentWeather(for cityName: String, completion: @escaping (Result<(OneCallWeatherDataModel,HourlyWeatherDataModel), Error>) -> Void)
    func searchCurrentWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees, completion: @escaping (Result<(OneCallWeatherDataModel,HourlyWeatherDataModel), Error>) -> Void)
}

protocol WeatherRequestProtocol {
    func performFiveDayWeatherRequest(for city: String, completion: @escaping (Result<HourlyWeatherDataModel, Error>) -> Void)
    func performFiveDayWeatherRequestLat(with latitude: CLLocationDegrees, and longitude: CLLocationDegrees, completion: @escaping (Result<HourlyWeatherDataModel, Error>) -> Void)
    func performOneCallWeatherRequest(with latitude: CLLocationDegrees, and longitude: CLLocationDegrees, completion: @escaping (Result<OneCallWeatherDataModel, Error>) -> Void)
    
}
