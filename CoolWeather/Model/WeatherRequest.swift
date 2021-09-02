//
//  WeatherManager.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import Foundation

struct WeatherRequest {
    
    func performFiveDayWeatherRequest(with urlString: String, completion: @escaping (Result<WeatherViewModel, Error>) -> Void) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(.failure(error!))
                    return
                }
                if let safeData = data {
                    if let weather = self.parseFiveDayWeatherJSON(safeData){
                        completion(.success(weather))
                    }
                }
            }
            task.resume()
        }
    }
    
    func performOneCallWeatherRequest(with urlString: String, completion: @escaping (Result<OneCallWeatherViewModel, Error>) -> Void) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
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
    private func parseOneCallWeatherJSON(_ weatherData: Data) -> OneCallWeatherViewModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(OneCallWeatherJSON.self, from: weatherData)

            var date: [Int] = []
            for i in 0..<decodedData.daily.count {
                date.append(decodedData.daily[i].dt)
            }
            
            var sunrise: [Int] = []
            for i in 0..<decodedData.daily.count {
                sunrise.append(decodedData.daily[i].sunrise)
            }
            
            var sunset: [Int] = []
            for i in 0..<decodedData.daily.count {
                sunset.append(decodedData.daily[i].sunset)
            }
            
            var moonrise: [Int] = []
            for i in 0..<decodedData.daily.count {
                moonrise.append(decodedData.daily[i].moonrise)
            }
            
            var moonset: [Int] = []
            for i in 0..<decodedData.daily.count {
                moonset.append(decodedData.daily[i].moonset)
            }
            
            var maximumTemperature: [Double] = []
            for i in 0..<decodedData.daily.count {
                maximumTemperature.append(decodedData.daily[i].temp.max)
            }
    
            var minimumTemperature: [Double] = []
            for i in 0..<decodedData.daily.count {
                minimumTemperature.append(decodedData.daily[i].temp.min)
            }
            
            let weather = OneCallWeatherViewModel(date: date,
                                                  sunrise: sunrise,
                                                  sunset: sunset,
                                                  moonrise: moonrise,
                                                  moonset: moonset,
                                                  maximumTemperatureOfTheDay: maximumTemperature,
                                                  minimumTemperatureOfTheDay: minimumTemperature)
            
            return weather
        }
        catch{
            print("\(error)")
            return nil
        }
    }
    

    
    private func parseFiveDayWeatherJSON(_ weatherData: Data) -> WeatherViewModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherJSON.self, from: weatherData)
            let newHumidity = decodedData.list[0].main.humidity
            let seaLevel = decodedData.list[0].main.sea_level
            let pressure = decodedData.list[0].main.pressure
            let windSpeed = decodedData.list[0].wind.speed
            let gust = decodedData.list[0].wind.gust
            let latitude = decodedData.city.coord.lat
            let longitude = decodedData.city.coord.lon
            
            let name = decodedData.city.name
            let minTemp = decodedData.list[0].main.temp_min
            let maxTemp = decodedData.list[0].main.temp_max
            
            var conditionName: [String] = []
            
            var id: [Int] = []
            for i in 0..<decodedData.list.count {
                id.append(decodedData.list[i].weather[0].id)
                conditionName.append(checkConditionId(decodedData.list[i].weather[0].id))
            }
            
            var temperature: [Double] = []
            for i in 0..<decodedData.list.count {
                temperature.append(decodedData.list[i].main.temp)
            }
            
            var date: [Int] = []
            for i in 0..<decodedData.list.count {
                date.append(decodedData.list[i].dt)
            }

            var tempMaxMin: [Double:Double] = [:]
            for i in 0..<decodedData.list.count {
                tempMaxMin[decodedData.list[i].main.temp_min] = decodedData.list[i].main.temp_max
            }
            
            let weather = WeatherViewModel(conditionId: id,
                                           cityName: name,
                                           temperature: temperature,
                                           date: date,
                                           minTemperature: minTemp,
                                           maxTemperature: maxTemp,
                                           humidity: newHumidity,
                                           wind: windSpeed,
                                           pressure: pressure,
                                           gust: gust,
                                           seaLevel: seaLevel,
                                           conditionName: conditionName,
                                           latitude: latitude,
                                           longitude: longitude)
            
            return weather
        }
        catch{
            return nil
        }
    }
    
    func checkConditionId(_ id: Int) -> String {
        switch id {
                case 200...232:
                    return "Lightning"
                case 300...321:
                    return "Drizzle"
                case 500...531:
                    return "Rain"
                case 600...622:
                    return "Snow"
                case 701...781:
                    return "Fog"
                case 800:
                    return "ClearSky"
                case 801...804:
                    return "Lightning"
                default:
                    return "NotAvailable"
                }
    }
}



