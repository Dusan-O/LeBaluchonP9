//
//  ExchangeServiceTestCase.swift
//  Le Baluchon Tests
//
//  Created by Dusan Orescanin on 28/03/2022.
//

import XCTest
@testable import Le_Baluchon__P_9_

class ExchangeServiceTestCase: XCTestCase {
    
    // MARK: - FAILED: TEST IF CALLBACK ERROR
 
    func test_GetExchange_Should_Post_Failed_Callback_IfError() {
        /// Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: nil, response: nil, error: FakeExchangeResponseData.error))
        
        /// When
        let expectation = expectation(description: "Wait for queue change")
        exchangeService.getExchange { result in
            
            /// Then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - FAILED: NO DATAS, NO RESPONSES & NO ERRORS
    
    func test_GetExchange_Should_Post_Failed_Callback_If_NoData() {
        /// Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        
        /// When
        let expectation = expectation(description: "Wait for queue change")
        exchangeService.getExchange { result in
            
            /// Then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - FAILED: INCORRECT RESPONSES
    
    func test_GetExchange_Should_Post_Failed_Callback_If_Incorrect_Response() {
        /// Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: FakeExchangeResponseData.exchangeCorrectData, response: FakeExchangeResponseData.responseKO, error: nil))
        
        /// When
        let expectation = expectation(description: "Wait for queue change")
        exchangeService.getExchange { result in
            
            /// Then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    // MARK: - FAILED: INCORRECT DATAS
    
    func test_GetExchange_Should_Post_Failed_Callback_If_Incorrect_Data() {
        /// Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: FakeExchangeResponseData.exchangeIncorrectData, response: FakeExchangeResponseData.responseOK, error: nil))
        
        /// When
        let expectation = expectation(description: "Wait for queue change")
        exchangeService.getExchange { result in
            
            /// Then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - SUCCESS : CORRECT DATAS & CORRECT RESPONSES
    
    func test_GetExchange_Should_Post_Success_Callback_If_Correct_Data_And_Correct_Response() {
        /// Given
        let exchangeService = ExchangeService(
            session: URLSessionFake(data: FakeExchangeResponseData.exchangeCorrectData, response: FakeExchangeResponseData.responseOK, error: nil))
        
        /// When
        let expectation = expectation(description: "Wait for queue change")
        exchangeService.getExchange { result in
            
            /// Then
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
