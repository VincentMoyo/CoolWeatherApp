//
//  RetrievedWeatherData.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import Foundation

struct WeatherData {
    
    private var initialConditionName: [String] = []
    private var initialCityName = ""
    private var initialTemperature: [Double] = []
    private var initialDate: [Int] = []
    private var initialMaximumTemperature = 0.0
    private var initialMinimumTemperature = 0.0
    private var initialSeaLevel = 0
    private var initialHumidity = 0
    private var initialWindSpeed = 0.0
    private var initialPressure = 0
    private var initialGust = 0.0
    private var initialLatitude = 0.0
    private var initialLongitude = 0.0
    private var initialOneCallWeatherDate: [Int] = []
    private var initialMaximumTemperatureOfTheDay: [Double] = []
    private var initialMinimumTemperatureOfTheDay: [Double] = []
    private var initialSunset: [Int] = []
    private var initialSunrise: [Int] = []
    private var initialMoonset: [Int] = []
    private var initialMoonrise: [Int] = []
    
    var maximumTemperatureOfDay: [Double] {
        get { return initialMaximumTemperatureOfTheDay }
        set { initialMaximumTemperatureOfTheDay = newValue }
    }
    var minimumTemperatureOfDay: [Double] {
        get { return initialMinimumTemperatureOfTheDay }
        set { initialMinimumTemperatureOfTheDay = newValue }
    }
    var sunset: [Int] {
        get { return initialSunset }
        set { initialSunset = newValue }
    }
    var sunrise: [Int] {
        get { return initialSunrise }
        set { initialSunrise = newValue }
    }
    var moonset: [Int] {
        get { return initialMoonset }
        set { initialMoonset = newValue }
    }
    var moonrise: [Int] {
        get { return initialMoonrise }
        set { initialMoonrise = newValue }
    }
    
    var conditionName: [String] {
        get { return initialConditionName }
        set { initialConditionName = newValue}
    }
    
    var cityName: String {
        get { return initialCityName }
        set { initialCityName = newValue }
    }
    
    var temperature: [Double] {
        get { return initialTemperature }
        set { initialTemperature = newValue }
    }
    
    var latitude: Double {
        get { return initialLatitude }
        set { initialLatitude = newValue }
    }
    
    var longitude: Double {
        get { return initialLongitude }
        set { initialLongitude = newValue }
    }
    
    var maximumTemperature: Double {
        get { return initialMaximumTemperature }
        set { initialMaximumTemperature = newValue }
    }
    
    var minimumTemperature: Double {
        get { return initialMaximumTemperature }
        set { initialMinimumTemperature = newValue }
    }
    
    var date: [Int] {
        get { return initialDate }
        set { initialDate = newValue }
    }
    
    var oneCallDate: [Int] {
        get { return initialOneCallWeatherDate }
        set { initialOneCallWeatherDate = newValue }
    }
    
    var seaLevel: Int {
        get { return initialSeaLevel }
        set { initialSeaLevel = newValue }
    }
    
    var humidity: Int {
        get { return initialHumidity }
        set { initialHumidity = newValue }
    }
    
    var windSpeed: Double {
        get { return initialWindSpeed }
        set { initialWindSpeed = newValue }
    }
    
    var pressure: Int {
        get { return initialPressure }
        set { initialPressure = newValue }
    }
    
    var gust: Double {
        get { return initialGust }
        set { initialGust = newValue }
    }
}
