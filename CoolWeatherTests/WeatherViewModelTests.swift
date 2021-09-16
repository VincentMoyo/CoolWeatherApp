//
//  WeatherViewModelTests.swift
//  CoolWeatherTests
//
//  Created by Vincent Moyo on 2021/09/16.
//

import XCTest
@testable import CoolWeather

class WeatherViewModelTests: XCTestCase {
    
    var implementationUnderTests: WeatherViewModel!
    
    override func setUpWithError() throws {
        implementationUnderTests = WeatherViewModel()
    }
    
    func testCitySearch() {
        let waitingForCompletionException = expectation(description: "Waiting for Open Weather API to respond using city name")
        implementationUnderTests.searchCurrentWeather(for: "Benoni")
        implementationUnderTests.didHomeViewModelLoad = { result in
            if result {
                waitingForCompletionException.fulfill()
            }
        }
        wait(for: [waitingForCompletionException], timeout: 5)
    }
    
    func testCoordinatesSearch() {
        let waitingForCompletionException = expectation(description: "Waiting for Open Weather API to respond using coordinates")
        implementationUnderTests.searchCurrentWeather(-26.11898, 28.37386)
        implementationUnderTests.didHomeViewModelLoad = { result in
            if result {
                waitingForCompletionException.fulfill()
            }
        }
        wait(for: [waitingForCompletionException], timeout: 5)
    }
    
    func testCurrentStyleDate() {
        let result = implementationUnderTests.formattedCurrentStyleDate(for: 1631786400)
        XCTAssertEqual(result, "Thursday")
    }
    
    func testShortStyleDate() {
        let result = implementationUnderTests.formattedShortStyleTime(for: 1631786400)
        XCTAssertEqual(result, "12:00 PM")
    }
}
