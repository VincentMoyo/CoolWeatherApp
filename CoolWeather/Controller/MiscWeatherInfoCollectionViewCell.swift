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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    private var todayWeatherCondition: Icon? {
//        return Icon(rawValue: "pressure")
//    }
    
    func configure(newLabel labelsData: String, newValue valueData: String) {

        iconImage.image = UIImage(systemName: backGroundImagesName(todayWeatherCondition: Icon(rawValue: labelsData)!))
        actualData.text = valueData
        labelData.text = labelsData
    }
    
    func backGroundImagesName(todayWeatherCondition: Icon) -> String {
        switch todayWeatherCondition {
        case .windspeed:
            return "wind"
        case .pressure:
            return "seal"
        case .windDegree:
            return "location.north.line"
        case .seaLevel:
            return "wake"
        case .sunrise:
            return "sunrise"
        case .sunset:
            return "sunset"
        case .moonrise:
            return "moon"
        case .moonset:
            return "moon.zzz"
        case .visibility:
            return "cloud.fog"
        case .humidity:
            return "lasso"
        case .uvProtection:
            return "cloud.rain"
        case .gust:
            return "wind.snow"
        }
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
