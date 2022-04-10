//
//  WeatherServiceTestCase.swift
//  Le Baluchon Tests
//
//  Created by Dusan Orescanin on 28/03/2022.
//

import XCTest
@testable import Le_Baluchon__P_9_

class WeatherServiceTestCase: XCTestCase {
    
    // MARK: - FAILED: TEST IF CALLBACK ERROR
    
    func testGetWeatherShouldPostFailedCallbackIfError() {
        /// Given
        let weatherService = WeatherServices(
            session: URLSessionFake(data: nil, response: nil, error: FakeWeatherResponseData.error))
        
        /// When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        weatherService.getWeather(urlString: "https://openclassroom.com") { (response) in
            
            /// Then
            XCTAssertNil(response)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - FAILED: NO DATAS, NO RESPONSES & NO ERRORS
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        /// Given
        let weatherService = WeatherServices(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        
        /// When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        weatherService.getWeather(urlString: "https://openclassroom.com") { (response) in
            
            /// Then
            XCTAssertNil(response)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - FAILED: INCORRECT RESPONSES
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        /// Given
        let weatherService = WeatherServices(
            session: URLSessionFake(data: FakeWeatherResponseData.weatherCorrectData, response: FakeWeatherResponseData.responseKO, error: nil))
        
        /// When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        weatherService.getWeather(urlString: "https://openclassroom.com") { (response) in
            
            /// Then
            XCTAssertNil(response)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - FAILED: INCORRECT DATAS
    
    func testGetWeatherShouldPostFailedCallbackIfiIncorrectData() {
        /// Given
        let weatherService = WeatherServices(
            session: URLSessionFake(data: FakeWeatherResponseData.weatherIncorrectData, response: FakeWeatherResponseData.responseOK, error: nil))
        
        /// When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        weatherService.getWeather(urlString: "https://openclassroom.com") { (response) in
            
            /// Then
            XCTAssertNil(response)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    // MARK: - SUCCESS : CORRECT DATAS & CORRECT RESPONSES
    
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        /// Given
        let weatherService = WeatherServices(
            session: URLSessionFake(data: FakeWeatherResponseData.weatherCorrectData, response: FakeWeatherResponseData.responseOK, error: nil))
        
        /// When
        let expectation = XCTestExpectation(description: "wait for queue change.")
        weatherService.getWeather(urlString: "https://openclassroom.com") { (result) in
            
            /// Then
            let description = "couvert"
            let temp = 4.86
            let icon = "01d"
            XCTAssertNotNil(result)
            XCTAssertEqual(description, result?.weather[0].description)
            XCTAssertEqual(temp, result?.main.temperature)
            XCTAssertEqual(icon, result?.weather[0].icon)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
