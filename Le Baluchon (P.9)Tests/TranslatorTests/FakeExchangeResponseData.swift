//
//  FakeExchangeResponseData.swift
//  Le Baluchon Tests
//
//  Created by Dusan Orescanin on 28/03/2022.
//

import Foundation

class FakeExchangeResponseData {
    
    // MARK: - DATA
    
    static var exchangeCorrectData: Data {
        let bundle = Bundle(for: FakeExchangeResponseData.self)
        let url = bundle.url(forResource: "Exchange", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let exchangeIncorrectData = "error".data(using: .utf8)
    
    // MARK: - RESPONSE
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://github.com")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://github.com")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - ERROR
    
    class ExchangeError: Error{}
    static let error = ExchangeError()
}
