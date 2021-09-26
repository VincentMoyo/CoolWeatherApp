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
    var weatherRequestRepository: WeatherViewModelRepository!
    
    override func setUpWithError() throws {
        implementationUnderTests = WeatherViewModel()
        weatherRequestRepository = WeatherViewModelRepository()
    }
    
    func testCitySearch() {
        let waitingForCompletionException = expectation(description: "Waiting for Open Weather API to respond using city name")
        implementationUnderTests.searchCurrentWeather(for: "Benoni")
        implementationUnderTests.modelLoad = { result in
            if result {
                waitingForCompletionException.fulfill()
            }
        }
        wait(for: [waitingForCompletionException], timeout: 5)
    }
    
    func testCoordinatesSearch() {
        let waitingForCompletionException = expectation(description: "Waiting for Open Weather API to respond using coordinates")
        implementationUnderTests.searchCurrentWeather(-26.11898, 28.37386)
        implementationUnderTests.modelLoad = { result in
            if result {
                waitingForCompletionException.fulfill()
            }
        }
        wait(for: [waitingForCompletionException], timeout: 5)
    }
    
    func testUsingMock() {
        let mockSession = URLSessionMock()
        mockSession.data = "testingData".data(using: .ascii)
        let waitingForCompletionException = expectation(description: "Waiting for Open Weather API to respond using coordinates")
        weatherRequestRepository.performURLSession(for: mockSession) { result in
            waitingForCompletionException.fulfill()
        }
        wait(for: [waitingForCompletionException], timeout: 5)
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
        init(closure: @escaping () -> Void) {
            self.closure = closure
        }
        // override resume and call the closure

        override func resume() {
            closure()
        }
}

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    override func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
        ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}
