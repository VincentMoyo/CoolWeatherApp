//
//  WeatherViewModelTests.swift
//  CoolWeatherTests
//
//  Created by Vincent Moyo on 2021/09/16.
//

import XCTest
@testable import CoolWeather

class WeatherViewModelTests: XCTestCase {
        
    var implementationUnderTests: WeatherRepositoryProtocol!
    var weatherRequest: WeatherRequest!
    
    override func setUpWithError() throws {
        implementationUnderTests = MockedViewModel()
        weatherRequest = WeatherRequest()
    }
    
//    func testCoordinateSearch() {
//        let waitingForCompletionException = expectation(description: "Waiting for searchWeather function to complete")
//        implementationUnderTests.repositoryLoad = { result in
//            if result {
//                waitingForCompletionException.fulfill()
//            }
//        }
//        implementationUnderTests.searchCurrentWeather(for: "Benoni")
//        wait(for: [waitingForCompletionException], timeout: 5)
//    }
    
    func testCitySearch() {
        let waitingForCompletionException = expectation(description: "Waiting for Open Weather API to respond using city name")
        implementationUnderTests.repositoryLoad = { result in
            if result {
                waitingForCompletionException.fulfill()
            }
        }
        implementationUnderTests.searchCurrentWeather(for: "Benoni")
        wait(for: [waitingForCompletionException], timeout: 5)
    }

//    func testCoordinatesSearch() {
//        let waitingForCompletionException = expectation(description: "Waiting for Open Weather API to respond using coordinates")
//        implementationUnderTests.searchCurrentWeather(-26.11898, 28.37386)
//        implementationUnderTests.modelLoad = { result in
//            if result {
//                waitingForCompletionException.fulfill()
//            }
//        }
//        wait(for: [waitingForCompletionException], timeout: 5)
//    }
}

