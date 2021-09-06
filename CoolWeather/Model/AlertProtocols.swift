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
