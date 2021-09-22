//
//  MiscellaneousInformationViewController.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/06.
//

import UIKit

class MiscellaneousInformationViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let miscellaneousInformationDataModel: MiscWeatherData
    private var miscWeatherDataList: [String: String] = [:]
    init(mistWeatherData: MiscWeatherData) {
        self.miscellaneousInformationDataModel = mistWeatherData
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setMiscWeatherDataList(mistWeatherData: miscellaneousInformationDataModel)
        collectionView.register(UINib(nibName: "MiscWeatherInfoCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundView = UIImageView(image: UIImage(named: "IconBackgroud"))
        collectionView.frame = view.bounds
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func setMiscWeatherDataList(mistWeatherData: MiscWeatherData) {
        miscWeatherDataList["sunrise"] = mistWeatherData.sunrise
        miscWeatherDataList["sunset"] = mistWeatherData.sunset
        miscWeatherDataList["moonrise"] = mistWeatherData.moonrise
        miscWeatherDataList["moonset"] = mistWeatherData.moonset
        miscWeatherDataList["uvProtection"] = mistWeatherData.uvProtection
        miscWeatherDataList["humidity"] = mistWeatherData.humidity
        miscWeatherDataList["visibility"] = mistWeatherData.visibility
        miscWeatherDataList["pressure"] = mistWeatherData.pressure
        miscWeatherDataList["seaLevel"] = mistWeatherData.seaLevel
        miscWeatherDataList["windspeed"] = mistWeatherData.windspeed
        miscWeatherDataList["windDegree"] = mistWeatherData.windDegree
        miscWeatherDataList["gust"] = mistWeatherData.gust
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                      for: indexPath) as? MiscWeatherInfoCollectionViewCell
        cell?.configure(newLabel: Array(miscWeatherDataList.keys)[indexPath.row], newValue: Array(miscWeatherDataList.values)[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return miscWeatherDataList.count
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
