//
//  ViewController.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/30.
//

import UIKit
import CoreLocation
import DropDown

class WeatherViewController: UIViewController, ErrorReporting {
    
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var maximumTemperatureForTheDay: UILabel!
    @IBOutlet private weak var minimumTemperatureForTheDay: UILabel!
    @IBOutlet private weak var mainTemperature: UILabel!
    @IBOutlet private weak var fiveDayForecastCollectionView: UICollectionView!
    @IBOutlet private weak var currentWeatherIcon: UIImageView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var temperatureBackgroundImage: UIImageView!
    @IBOutlet private weak var fiveDayCollectionView: UICollectionView!
    @IBOutlet weak var locationView: UIView!
    
    @IBOutlet private weak var seaLevel: UILabel!
    @IBOutlet private weak var humidity: UILabel!
    @IBOutlet private weak var pressure: UILabel!
    @IBOutlet private weak var windSpeed: UILabel!
    
    lazy private var weatherViewModel = WeatherViewModel()
    let defaults = UserDefaults.standard
    
    let menu: DropDown = {
        let menu = DropDown()
        menu.cellNib = UINib(nibName: "DropDownCell", bundle: nil)
        menu.customCellConfiguration = {_, _, cell in
            guard let cell = cell as? UserLocationsDropDownCell else {
                return
            }
        }
        return menu
    }()
    
    var userLocations = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherViewModel.locationManager.delegate = self
        searchTextField.delegate = self
        currentWeatherIcon.layer.cornerRadius = currentWeatherIcon.frame.size.width / 2
        weatherViewModel.requestLocation()
        bindHomeViewModelErrors()
        bindHomeViewModel()
        menu.anchorView = locationView
    
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapLocationView))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        locationView.addGestureRecognizer(gesture)
        menu.selectionAction = {index, title in
            self.locationSelected(title, index)
        }
        
        if let items = defaults.array(forKey: "UserLocations") as? [String] {
            userLocations = items
            menu.dataSource = items
        }
    }
    
    @objc func didTapLocationView() {
        menu.show()
    }
    
    @IBAction func currentLocationPressed(_ sender: Any) {
        weatherViewModel.requestLocation()
    }
    
    @IBAction func seeMorePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constants.kMiscellaneousIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.kMiscellaneousIdentifier {
            let destinationVC = segue.destination as? MiscellaneousInformationViewController
            
            destinationVC?.gust = String(weatherViewModel.gust)
            destinationVC?.humidity = String(weatherViewModel.humidity)
            destinationVC?.windDegree = String(weatherViewModel.windSpeedDegree)
            destinationVC?.visibility = String(weatherViewModel.visibility)
            destinationVC?.pressure = String(weatherViewModel.pressure)
            destinationVC?.seaLevel = String(weatherViewModel.seaLevel)
            destinationVC?.windspeed = String(weatherViewModel.windSpeed)
            destinationVC?.uvProtection = String(weatherViewModel.uvProtection)
            destinationVC?.sunrise = weatherViewModel.formattedShortStyleTime(for: TimeInterval(weatherViewModel.sunrise))
            destinationVC?.sunset = weatherViewModel.formattedShortStyleTime(for: TimeInterval(weatherViewModel.sunset))
            destinationVC?.moonset = weatherViewModel.formattedShortStyleTime(for: TimeInterval(weatherViewModel.moonset))
            destinationVC?.moonrise = weatherViewModel.formattedShortStyleTime(for: TimeInterval(weatherViewModel.moonrise))
        }
    }
    
    private func bindHomeViewModel() {
        weatherViewModel.didHomeViewModelLoad = { result in
            if result {
                DispatchQueue.main.async {
                    self.cityNameLabel.text = self.weatherViewModel.cityName
                    self.addIconsAndBackgroundImages()
                    self.addTemperaturesForTheDay()
                    self.addMiscellaneousInformationToView()
                    self.fiveDayForecastCollectionView.reloadData()
                    self.fiveDayCollectionView.reloadData()
                }
            }
        }
    }
    
    private func addIconsAndBackgroundImages() {
        self.temperatureBackgroundImage.image =
            UIImage.animatedImageNamed(self.weatherViewModel.backGroundImagesName(),
                                       duration: 30)
        self.currentWeatherIcon.image = UIImage(named: self.weatherViewModel.conditionName[0])
    }
    
    private func addTemperaturesForTheDay() {
        self.mainTemperature.text = String(self.weatherViewModel.temperature[0]) + weatherViewModel.appendCelsiusSymbol()
        self.maximumTemperatureForTheDay.text = String(self.weatherViewModel.maxTemperature) + weatherViewModel.appendCelsiusSymbol()
        self.minimumTemperatureForTheDay.text = String(self.weatherViewModel.minTemperature) + weatherViewModel.appendCelsiusSymbol()
    }
    
    private func addMiscellaneousInformationToView() {
        self.seaLevel.text = String(self.weatherViewModel.seaLevel)
        self.humidity.text = String(self.weatherViewModel.humidity)
        self.pressure.text = String(self.weatherViewModel.pressure)
        self.windSpeed.text = String(self.weatherViewModel.windSpeed)
    }
    
    func bindHomeViewModelErrors() {
        weatherViewModel.homeViewModelError = { result in
            self.showUserErrorMessageDidInitiate(result.localizedDescription)
        }
    }
}

// MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchCityPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        if let city = searchTextField.text {
            weatherViewModel.searchCurrentWeather(for: city)
            
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherViewModel.searchCurrentWeather(for: city)
            if userLocations.contains(city) == false {
                userLocations.append(city)
            }
            defaults.setValue(userLocations, forKey: "UserLocations")
            menu.dataSource = userLocations
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text?.isEmpty == false {
            textField.placeholder = "Search"
            return true
        }
        textField.placeholder = "Please a city"
        return false
    }
}

// MARK: - Location Manager
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        weatherViewModel.locationManager(manager, didUpdateLocations: locations)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showUserErrorMessageDidInitiate(error.localizedDescription)
    }
}

// MARK: - CollectionView
extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.fiveDayForecastCollectionView {
            return weatherViewModel.temperature.count
        } else if collectionView == self.fiveDayCollectionView {
            return weatherViewModel.oneCallDates.count
        }
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == fiveDayCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentification.kFiveDaysCollectionView,
                                                          for: indexPath) as? FiveDaysCollectionViewCell
            cell?.configure(date: weatherViewModel.formattedCurrentStyleDate(for: TimeInterval(weatherViewModel.oneCallDates[indexPath.row])),
                            minimumTemperature: String(weatherViewModel.minimumTemperatureOfTheDay[indexPath.row]) + weatherViewModel.appendCelsiusSymbol(),
                            maximumTemperature: String(weatherViewModel.maximumTemperatureOfTheDay[indexPath.row]) + weatherViewModel.appendCelsiusSymbol(),
                            weatherIcon: UIImage(named: weatherViewModel.conditionName[indexPath.row]) ?? UIImage())
            return cell ?? FiveDaysCollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentification.kForecastCollectionView,
                                                          for: indexPath) as? ForecastCollectionViewCell
            cell?.configure(date: weatherViewModel.formattedCurrentStyleDate(for: TimeInterval(weatherViewModel.date[indexPath.row])),
                            time: weatherViewModel.formattedShortStyleTime(for: TimeInterval(weatherViewModel.date[indexPath.row])),
                            iconImage: UIImage(named: weatherViewModel.conditionName[indexPath.row]) ?? UIImage(),
                            temperature: String(weatherViewModel.temperature[indexPath.row]) + weatherViewModel.appendCelsiusSymbol())
            return cell ?? ForecastCollectionViewCell()
        }
    }
}

// MARK: - Error handling
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
    
    func locationSelected(_ title: String, _ index: Int) {
        let alertController = UIAlertController(title: title,
                                                message: "Do you want search or delete \(title)?",
                                                preferredStyle: .alert)
        
        let searchAction = UIAlertAction(title: "Search", style: UIAlertAction.Style.default) { _ in
            self.weatherViewModel.searchCurrentWeather(for: title)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertAction.Style.default) { _ in
            self.userLocations.remove(at: index)
            self.defaults.setValue(self.userLocations, forKey: "UserLocations")
            self.menu.dataSource = self.userLocations
        }
        
        alertController.addAction(searchAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
    }
}
