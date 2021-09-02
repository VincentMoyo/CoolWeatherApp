//
//  ViewController.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var maximumTemperatureForTheDay: UILabel!
    @IBOutlet weak var minimumTemperatureForTheDay: UILabel!
    @IBOutlet weak var mainTemperature: UILabel!
    @IBOutlet weak var fiveDayForecastCollectionView: UICollectionView!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var TemperatureBackgroundImage: UIImageView!
    @IBOutlet weak var fiveDayCollectionView: UICollectionView!
    
    @IBOutlet weak var seaLevel: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    
    let homeViewModel = HomeViewModel()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        searchWeather()
        bindHomeViewModel()
    }
    
    @IBAction func currentLocationPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
    @IBAction func searchCityPressed(_ sender: UIButton) {
        if let city = searchTextField.text{
            homeViewModel.searchCurrentWeather(for: city)
        }
        //searchTextField.endEditing(true)
        searchTextField.text = ""
    }
    
    func searchWeather() {
        bindHomeViewModelErrors()
        homeViewModel.searchCurrentWeather(for: "Benoni")
    }
    
    private func bindHomeViewModel() {
        homeViewModel.didHomeViewModelLoad = { result in
            if result {
                DispatchQueue.main.async {
                    self.cityNameLabel.text = self.homeViewModel.weatherData.cityName
                    self.TemperatureBackgroundImage.image = UIImage.animatedImageNamed(self.homeViewModel.checkBackGroundImage(self.homeViewModel.weatherData.conditionName[0]),
                                                                                       duration: 30)
                    self.currentWeatherIcon.image = UIImage(named: self.homeViewModel.weatherData.conditionName[0])
                    self.mainTemperature.text = String(self.homeViewModel.weatherData.temperature[0])
                    self.maximumTemperatureForTheDay.text = String(self.homeViewModel.weatherData.maximumTemperature)
                    self.minimumTemperatureForTheDay.text = String(self.homeViewModel.weatherData.minimumTemperature)
                    self.seaLevel.text = String(self.homeViewModel.weatherData.seaLevel)
                    self.humidity.text = String(self.homeViewModel.weatherData.humidity)
                    self.pressure.text = String(self.homeViewModel.weatherData.pressure)
                    self.windSpeed.text = String(self.homeViewModel.weatherData.windSpeed)
                    self.fiveDayForecastCollectionView.reloadData()
                    self.fiveDayCollectionView.reloadData()
                }
            }
        }
    }
    
    func bindHomeViewModelErrors() {
        homeViewModel.homeViewModelError = { result in
            print("\(result)")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.fiveDayForecastCollectionView {
            return homeViewModel.weatherData.temperature.count
        }
        else if collectionView == self.fiveDayCollectionView {
            return homeViewModel.weatherData.oneCallDate.count
        }
       return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.fiveDayCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiveDaysCollectionView", for: indexPath) as? FiveDaysCollectionViewCell
            cell?.date.text = homeViewModel.convertDate(homeViewModel.weatherData.oneCallDate[indexPath.row])
            cell?.min.text = String(homeViewModel.weatherData.minimumTemperatureOfDay[indexPath.row])
            cell?.max.text = String(homeViewModel.weatherData.maximumTemperatureOfDay[indexPath.row])
            return cell ?? FiveDaysCollectionViewCell.init()
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCollectionView", for: indexPath) as? ForecastCollectionViewCell
            cell?.dateLabel.text = homeViewModel.convertDate(homeViewModel.weatherData.date[indexPath.row])
            cell?.timeLabel.text = homeViewModel.convertTime(homeViewModel.weatherData.date[indexPath.row])
            cell?.iconImage.image = UIImage(named: homeViewModel.weatherData.conditionName[indexPath.row])
            cell?.temperatureLabel.text = String(homeViewModel.weatherData.temperature[indexPath.row])
            return cell ?? ForecastCollectionViewCell.init()
        }
        
        
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            homeViewModel.searchCurrentWeather(lat,lon)
        }
        print("Got location manager")
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
