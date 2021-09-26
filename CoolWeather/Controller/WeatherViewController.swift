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
    @IBOutlet private weak var locationView: UIView!
    @IBOutlet private weak var sunriseTime: UILabel!
    @IBOutlet private weak var sunsetTime: UILabel!
    @IBOutlet private weak var moonriseTime: UILabel!
    @IBOutlet private weak var moonsetTime: UILabel!
    lazy private var weatherViewModel = WeatherViewModel(weatherRepository: WeatherViewModelRepository())
    
    var hopeFullness = WeatherViewModelRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherViewModel.locationManager.delegate = self
        searchTextField.delegate = self
        currentWeatherIcon.layer.cornerRadius = currentWeatherIcon.frame.size.width / 2
        weatherViewModel.requestLocation()
        bindHomeViewModelErrors()
        bindHomeViewModel()
        menu.anchorView = locationView
        setUpDidTapLocationView()
        selectionUponMenu()
        weatherViewModel.loadUserLocationsFromUserDefaults()
    }
    
    private func bindHomeViewModel() {
        weatherViewModel.modelLoad = { result in
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
        guard let temperature = weatherViewModel.temperature(at: 0) else {
            return
        }
        
        self.mainTemperature.text = temperature
        self.maximumTemperatureForTheDay.text = self.weatherViewModel.maxTemperature
        self.minimumTemperatureForTheDay.text = self.weatherViewModel.minTemperature
    }
    
    private func addMiscellaneousInformationToView() {
        self.sunriseTime.text = weatherViewModel.sunrise
        self.sunsetTime.text = weatherViewModel.sunset
        self.moonriseTime.text = weatherViewModel.moonrise
        self.moonsetTime.text = weatherViewModel.moonset
    }
    
    private func selectionUponMenu() {
        menu.selectionAction = {index, title in
            self.locationSelected(title, index)
        }
    }
    
    private func setUpDidTapLocationView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapLocationView))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        locationView.addGestureRecognizer(gesture)
    }
    
    @objc func didTapLocationView() {
        menu.show()
    }
    
    @IBAction func currentLocationPressed(_ sender: Any) {
        weatherViewModel.requestLocation()
    }
    
    // MARK: - Passing Data to Miscellaneous ViewController
    
    @IBAction func seeMorePressed(_ sender: UIButton) {
        let controller = MiscWeatherViewController(mistWeatherData: weatherViewModel.getInfo())
            show(controller, sender: sender)
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
            weatherViewModel.addCityToUserDefault(city)
            weatherViewModel.updateUserDefaults()
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text?.isEmpty == false {
            textField.placeholder = Constants.AlertButtonTexts.kSearch
            return true
        }
        textField.placeholder = Constants.AlertButtonTexts.kSearch
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

// MARK: - Drop Down Menu

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

// MARK: - CollectionView
extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == fiveDayForecastCollectionView {
            return weatherViewModel.temperature.count
        } else if collectionView == fiveDayCollectionView {
            return weatherViewModel.oneCallDates.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == fiveDayCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentification.kFiveDaysCollectionView,
                                                          for: indexPath) as? FiveDaysCollectionViewCell
            
            guard let minimumTemperateAtCurrentDate = weatherViewModel.minimumTemperatureAtDate(at: indexPath.row),
                  let maximumTemperateAtCurrentDate = weatherViewModel.maximumTemperatureAtDate(at: indexPath.row),
                  let conditionName = weatherViewModel.conditionNameAtDate(at: indexPath.row),
                  let currentSelectedDate = weatherViewModel.UTCDateConvertedToDateFrom(index: indexPath.row)
            else {
                return ForecastCollectionViewCell()}
            
            cell?.configure(date: currentSelectedDate,
                            minimumTemperature: minimumTemperateAtCurrentDate,
                            maximumTemperature: maximumTemperateAtCurrentDate,
                            weatherIcon: UIImage(named: conditionName) ?? UIImage())
            return cell ?? FiveDaysCollectionViewCell()
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentification.kForecastCollectionView,
                                                          for: indexPath) as? ForecastCollectionViewCell
            
            guard let temperature = weatherViewModel.temperature(at: indexPath.row),
                  let conditionName = weatherViewModel.conditionNameAtDate(at: indexPath.row),
                  let currentSelectedDate = weatherViewModel.UTCDateConvertedToDateFrom(index: indexPath.row),
                  let currentSelectedTime = weatherViewModel.UNTCTimeConvertedToTimeFrom(index: indexPath.row)
            else {
                return ForecastCollectionViewCell()}
            
            cell?.configure(date: currentSelectedDate,
                            time: currentSelectedTime,
                            iconImage: UIImage(named: conditionName) ?? UIImage(),
                            temperature: temperature)
            return cell ?? ForecastCollectionViewCell()
        }
    } 
}

// MARK: - Error handling
extension WeatherViewController {
    
    func bindHomeViewModelErrors() {
        weatherViewModel.modelError = { result in
            self.showUserErrorMessageDidInitiate(result.localizedDescription)
        }
    }
    
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
                                                message: NSLocalizedString("SEARCH_OR_DELETE_CONFIRMATION", comment: "") + "\(title)?",
                                                preferredStyle: .alert)
        let searchAction = UIAlertAction(title: Constants.AlertButtonTexts.kSearch, style: UIAlertAction.Style.default) { _ in
            self.weatherViewModel.searchCurrentWeather(for: title)
        }
        let deleteAction = UIAlertAction(title: Constants.AlertButtonTexts.kDelete, style: UIAlertAction.Style.default) { _ in
            self.weatherViewModel.userLocations.remove(at: index)
            self.weatherViewModel.updateUserDefaults()
        }
        alertController.addAction(searchAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
    }
}
