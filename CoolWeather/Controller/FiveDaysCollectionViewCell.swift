//
//  FiveDaysCollectionViewCell.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/02.
//

import UIKit

class FiveDaysCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
