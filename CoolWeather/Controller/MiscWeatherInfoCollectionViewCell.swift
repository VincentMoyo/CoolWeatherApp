//
//  MiscWeatherInfoCollectionViewCell.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/21.
//

import UIKit

class MiscWeatherInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var actualData: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var labelData: UILabel!
    var miscWeatherInfoCollectionViewModel = MiscWeatherInfoCollectionViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(newLabel labelsData: String, newValue valueData: String) {

        iconImage.image = UIImage(systemName: miscWeatherInfoCollectionViewModel.backGroundImagesName(todayWeatherCondition: Icon(rawValue: labelsData)!))
        actualData.text = valueData
        labelData.text = labelsData
    }
}
enum Icon: String {
    case windspeed
    case pressure
    case windDegree
    case seaLevel
    case sunrise
    case sunset
    case moonrise
    case moonset
    case visibility
    case humidity
    case uvProtection
    case gust
}
