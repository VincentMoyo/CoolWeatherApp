//
//  MiscellaneousInformationViewController.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/06.
//

import UIKit

class MiscWeatherViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let miscellaneousInformationDataModel: MiscWeatherData
    private var miscWeatherViewModel = MiscWeatherViewModel()
    init(mistWeatherData: MiscWeatherData) {
        self.miscellaneousInformationDataModel = mistWeatherData
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        miscWeatherViewModel.setMiscWeatherDataList(mistWeatherData: miscellaneousInformationDataModel)
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
        cell?.configure(newLabel: Array(miscWeatherViewModel.miscWeatherDataList.keys)[indexPath.row],
                        newValue: Array(miscWeatherViewModel.miscWeatherDataList.values)[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return miscWeatherViewModel.miscWeatherDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.size.width/3)-3,
            height: (view.frame.size.width/3)-3
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 150, left: 1, bottom: 1, right: 1)
    }
}
