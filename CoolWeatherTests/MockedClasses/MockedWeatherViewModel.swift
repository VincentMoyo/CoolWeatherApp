//
//  MockedWeatherViewModel.swift
//  CoolWeatherTests
//
//  Created by Vincent Moyo on 2021/09/28.
//

import Foundation
@testable import CoolWeather
import CoreLocation

class MockedViewModel {
    
    var userLocations: [String]?
    var weather: HourlyWeatherDataModel?
    var oneCallAPI: OneCallWeatherDataModel?
    var repositoryLoad: ((Bool) -> Void)?
    var repositoryError: ((Error) -> Void)?
    
    func searchCurrentWeather(for cityName: String) {
        weather = HourlyWeatherDataModel(conditionId: [1],
                                         cityName: "",
                                         temperature: [1],
                                         date: [1],
                                         minTemperature: 1,
                                         maxTemperature: 1,
                                         humidity: 1,
                                         wind: 1.1,
                                         pressure: 1,
                                         gust: 1.1,
                                         seaLevel: 1,
                                         conditionName: [""],
                                         latitude: 1.1,
                                         longitude: 1.1,
                                         visibility: 1,
                                         windSpeedDegree: 1)
        requestOneWWeatherCallData(weather!.latitude, weather!.longitude)
    }
    
    func searchCurrentWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        weather = HourlyWeatherDataModel(conditionId: [1],
                                         cityName: "",
                                         temperature: [1],
                                         date: [1],
                                         minTemperature: 1,
                                         maxTemperature: 1,
                                         humidity: 1,
                                         wind: 1.1,
                                         pressure: 1,
                                         gust: 1.1,
                                         seaLevel: 1,
                                         conditionName: [""],
                                         latitude: 1.1,
                                         longitude: 1.1,
                                         visibility: 1,
                                         windSpeedDegree: 1)
        requestOneWWeatherCallData(weather!.latitude, weather!.longitude)
    }
    
    private func requestOneWWeatherCallData(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        oneCallAPI = OneCallWeatherDataModel(date: [1],
                                             sunrise: 1,
                                             sunset: 1,
                                             moonrise: 1,
                                             moonset: 1,
                                             maximumTemperatureOfTheDay: [1],
                                             minimumTemperatureOfTheDay: [1],
                                             uvProtection: 1.1)
        repositoryLoad?(true)
    }
}
