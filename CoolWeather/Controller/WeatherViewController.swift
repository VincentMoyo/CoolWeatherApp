//
//  ViewController.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var maximumTemperatureForTheDay: UILabel!
    @IBOutlet weak var minimumTemperatureForTheDay: UILabel!
    @IBOutlet weak var mainTemperature: UILabel!
    @IBOutlet weak var fiveDayForecastCollectionView: UICollectionView!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var temperatureBackgroundImage: UIImageView!
    @IBOutlet weak var fiveDayCollectionView: UICollectionView!
    
    @IBOutlet weak var seaLevel: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    
    lazy var weatherViewModel = WeatherViewModel()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        bindHomeViewModelErrors()
        bindHomeViewModel()
    }
    
    @IBAction func currentLocationPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchCityPressed(_ sender: UIButton) {
        if let city = searchTextField.text {
            weatherViewModel.searchCurrentWeather(for: city)
        }
        searchTextField.text = ""
    }
    
    private func bindHomeViewModel() {
        weatherViewModel.didHomeViewModelLoad = { result in
            if result {
                DispatchQueue.main.async {
                    self.cityNameLabel.text = self.weatherViewModel.weatherData.cityName
                    self.temperatureBackgroundImage.image =
                        UIImage.animatedImageNamed(self.weatherViewModel.checkBackGroundImage(self.weatherViewModel.weatherData.conditionName[0]),
                                                   duration: 30)
                    self.currentWeatherIcon.image = UIImage(named: self.weatherViewModel.weatherData.conditionName[0])
                    self.mainTemperature.text = String(self.weatherViewModel.weatherData.temperature[0])
                    self.maximumTemperatureForTheDay.text = String(self.weatherViewModel.weatherData.maximumTemperature)
                    self.minimumTemperatureForTheDay.text = String(self.weatherViewModel.weatherData.minimumTemperature)
                    self.seaLevel.text = String(self.weatherViewModel.weatherData.seaLevel)
                    self.humidity.text = String(self.weatherViewModel.weatherData.humidity)
                    self.pressure.text = String(self.weatherViewModel.weatherData.pressure)
                    self.windSpeed.text = String(self.weatherViewModel.weatherData.windSpeed)
                    self.fiveDayForecastCollectionView.reloadData()
                    self.fiveDayCollectionView.reloadData()
                }
            }
        }
    }
    
    func bindHomeViewModelErrors() {
        weatherViewModel.homeViewModelError = { result in
            self.showUserErrorMessageDidInitiate(result.localizedDescription)
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherViewModel.searchCurrentWeather(lat, lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showUserErrorMessageDidInitiate(error.localizedDescription)
    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.fiveDayForecastCollectionView {
            return weatherViewModel.weatherData.temperature.count
        } else if collectionView == self.fiveDayCollectionView {
            return weatherViewModel.weatherData.oneCallDate.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.fiveDayCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentification.kFiveDaysCollectionView,
                                                          for: indexPath) as? FiveDaysCollectionViewCell
            cell?.configure(date: weatherViewModel.convertDate(weatherViewModel.weatherData.oneCallDate[indexPath.row]),
                            minimumTemperature: String(weatherViewModel.weatherData.minimumTemperatureOfDay[indexPath.row]),
                            maximumTemperature: String(weatherViewModel.weatherData.maximumTemperatureOfDay[indexPath.row]),
                            weatherIcon: UIImage(named: weatherViewModel.weatherData.conditionName[indexPath.row])!)
            return cell ?? FiveDaysCollectionViewCell.init()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentification.kForecastCollectionView,
                                                          for: indexPath) as? ForecastCollectionViewCell
            cell?.configure(date: weatherViewModel.convertDate(weatherViewModel.weatherData.date[indexPath.row]),
                            time: weatherViewModel.convertTime(weatherViewModel.weatherData.date[indexPath.row]),
                            iconImage: UIImage(named: weatherViewModel.weatherData.conditionName[indexPath.row])!,
                            temperature: String(weatherViewModel.weatherData.temperature[indexPath.row]))
            return cell ?? ForecastCollectionViewCell.init()
        }
    }
}

extension WeatherViewController {
    func showUserErrorMessageDidInitiate(_ message: String) {
        let alertController = UIAlertController(title: NSLocalizedString("ERROR", comment: ""),
                                                message: message,
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                                style: .default,
                                                handler: nil))
        
        present(alertController, animated: true)
    }
}
