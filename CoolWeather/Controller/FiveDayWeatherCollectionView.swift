//
//  FiveDayWeatherCollectionView.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/02.
//

import UIKit

class FiveDayWeatherCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiveDaysCollectionView", for: indexPath) as? FiveDaysCollectionViewCell
        cell?.max.text = "Hello"
        return cell ?? FiveDaysCollectionViewCell.init()
    }
    


}
