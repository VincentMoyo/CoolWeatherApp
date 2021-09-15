//
//  UserLocationsDropDownCell.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/15.
//

import UIKit
import DropDown

class UserLocationsDropDownCell: DropDownCell {

    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func removeLocationPressed(_ sender: UIButton) {
        print("\(sender)")
    }
    
}
