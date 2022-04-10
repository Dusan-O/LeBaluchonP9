//
//  FakeWeatherResponseData.swift
//  Le Baluchon Tests
//
//  Created by Dusan Orescanin on 28/03/2022.
//

import Foundation

class FakeWeatherResponseData {
    
    // MARK: - DATA
    
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeWeatherResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let weatherIncorrectData = "error".data(using: .utf8)
    
    // MARK: - RESPONSE
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://github.com")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://github.com")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - ERROR
    
    class WeatherError: Error{}
    static let error = WeatherError()
    
}
