//
//  MiscWeatherInfoCollectionViewCell.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/21.
//

import UIKit

class MiscWeatherInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var actualData: UILabel!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var labelData: UILabel!
    
    private var miscWeatherInfoCollectionViewModel = MiscWeatherInfoCollectionViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(newLabel labelsData: String, newValue valueData: String) {
        guard let iconName = Icon(rawValue: labelsData) else { return }
        iconImage.image = UIImage(systemName: miscWeatherInfoCollectionViewModel.backGroundImagesName(todayWeatherCondition: iconName))
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
