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
    
    var windspeed: String?
    var gust: String?
    var windDegree: String?
    var seaLevel: String?
    var sunrise: String?
    var sunset: String?
    var moonrise: String?
    var moonset: String?
    var pressure: String?
    var visibility: String?
    var humidity: String?
    var uvProtection: String?
    
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
