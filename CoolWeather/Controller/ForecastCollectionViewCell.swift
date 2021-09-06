//
//  ForcastCollectionViewCell.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/08/31.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
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
