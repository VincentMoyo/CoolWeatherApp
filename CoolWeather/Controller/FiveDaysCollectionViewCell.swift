//
//  FiveDaysCollectionViewCell.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/02.
//

import UIKit

class FiveDaysCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var minimumTemperature: UILabel!
    @IBOutlet weak var maximumTemperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
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
