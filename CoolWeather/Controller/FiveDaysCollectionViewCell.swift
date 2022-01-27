//
//  FiveDaysCollectionViewCell.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/02.
//

import UIKit

class FiveDaysCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var date: UILabel!
    @IBOutlet private weak var minimumTemperature: UILabel!
    @IBOutlet private weak var maximumTemperature: UILabel!
    @IBOutlet private weak var weatherIcon: UIImageView!

    func configure(date convertedDate: String,
                   minimumTemperature currentMinimumTemperature: String,
                   maximumTemperature currentMaximumTemperature: String,
                   weatherIcon currentWeatherIcon: UIImage ) {
        date.text = convertedDate
        minimumTemperature.text = currentMinimumTemperature
        maximumTemperature.text = currentMaximumTemperature
        weatherIcon.image = currentWeatherIcon
    }
}
