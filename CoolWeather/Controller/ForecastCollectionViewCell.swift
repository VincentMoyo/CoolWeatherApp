//
//  ForcastCollectionViewCell.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/31.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    func configure(date convertedDate: String,
                   time convertedTime: String,
                   iconImage image: UIImage,
                   temperature currentTemperature: String) {
        
        dateLabel.text = convertedDate
        timeLabel.text = convertedTime
        iconImage.image = image
        temperatureLabel.text = currentTemperature
    }
}
