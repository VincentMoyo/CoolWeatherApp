//
//  MiscellaneousInformationViewController.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/06.
//

import UIKit

class MiscellaneousInformationViewController: UIViewController {
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var gustLabel: UILabel!
    @IBOutlet weak var windDegreeLabel: UILabel!
    @IBOutlet weak var seaLevelLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var moonriseLabel: UILabel!
    @IBOutlet weak var moonsetLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var uvProtectionLabel: UILabel!
    
    private var windspeed: String!
    private var gust: String!
    private var windDegree: String!
    private var seaLevel: String!
    private var sunrise: String!
    private var sunset: String!
    private var moonrise: String!
    private var moonset: String!
    private var pressure: String!
    private var visibility: String!
    private var humidity: String!
    private var uvProtection: String!
    
    func configure(windspeed convertedWindspeed: String,
                   gust convertedGust: String,
                   windDegree convertedWindDegree: String,
                   seaLevel convertedSeaLevel: String,
                   sunrise convertedSunrise: String,
                   sunset convertedSunset: String) {
        windspeed = convertedWindspeed
        gust = convertedGust
        windDegree = convertedWindDegree
        seaLevel = convertedSeaLevel
        sunrise = convertedSunrise
        sunset = convertedSunset
        
    }
    func configure(moonrise convertedMoonrise: String,
                   moonset convertedMoonset: String,
                   pressure convertedPressure: String,
                   visibility convertedVisibility: String,
                   humidity convertedHumidity: String,
                   uvProtection convertedUvProtection: String) {
        moonrise = convertedMoonrise
        moonset = convertedMoonset
        pressure = convertedPressure
        visibility = convertedVisibility
        humidity = convertedHumidity
        uvProtection = convertedUvProtection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        windDegreeLabel.text = windDegree
        windSpeedLabel.text = windspeed
        gustLabel.text = gust
        windSpeedLabel.text = windspeed
        seaLevelLabel.text = seaLevel
        sunriseLabel.text = sunrise
        sunsetLabel.text = sunset
        moonriseLabel.text = moonrise
        moonsetLabel.text = moonset
        pressureLabel.text = pressure
        visibilityLabel.text = visibility
        humidityLabel.text = humidity
        uvProtectionLabel.text = uvProtection
    }
}
