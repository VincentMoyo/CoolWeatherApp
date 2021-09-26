//
//  AlertProtocols.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/06.
//

import Foundation

protocol ErrorReporting: AnyObject {
    func showUserErrorMessageDidInitiate(_ message: String)
}

protocol HourlyAPI {
    typealias Handler = (Result<HourlyWeatherDataModel, Error>) -> Void
    func requestWeather(from url: URL, then handler: @escaping Handler)
}
