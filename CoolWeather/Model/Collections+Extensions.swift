//
//  Collections+Extensions.swift
//  CoolWeather
//
//  Created by Vincent Moyo on 2021/09/20.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
