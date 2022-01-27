//
//  MiscellaneousInformationViewController.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/06.
//

import UIKit

class MiscWeatherViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var miscWeatherViewModel: MiscWeatherViewModel
    
    init(mistWeatherData: MiscWeatherData) {
        miscWeatherViewModel = MiscWeatherViewModel(miscWeatherData: mistWeatherData)
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        collectionView.register(UINib(nibName: "MiscWeatherInfoCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundView = UIImageView(image: UIImage(named: "IconBackgroud"))
        collectionView.frame = view.bounds
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                      for: indexPath) as? MiscWeatherInfoCollectionViewCell
        
        guard let iconName = miscWeatherViewModel.iconName(at: indexPath.row),
              let iconValue = miscWeatherViewModel.iconValue(at: indexPath.row) else {
                  return UICollectionViewCell()
              }
        
        cell?.configure(newLabel: iconName, newValue: iconValue)
        
        return cell ?? UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        miscWeatherViewModel.miscWeatherDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: (view.frame.size.width/3)-3,
            height: (view.frame.size.width/3)-3
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 150, left: 1, bottom: 1, right: 1)
    }
}
