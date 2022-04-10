//
//  TranslatorServiceTestCase.swift
//  Le Baluchon Tests
//
//  Created by Dusan Orescanin on 28/03/2022.
//

import XCTest
@testable import Le_Baluchon__P_9_

class TranslatorServiceTestCase: XCTestCase {
    
    // MARK: - FAILED: TEST IF CALLBACK ERROR
    
    func test_GetTranslation_Should_Post_Failed_Callback_IfError() {
        /// Given
        let translationService = TranslateService(
            session: URLSessionFake(data: nil, response: nil, error: FakeWeatherResponseData.error))
        
        /// When
        let expectation = expectation(description: "Wait for queue change")
        translationService.getTranslation(for: "https://openclassrooms.com", target: "en", source: "fr") { result in
            
            /// Then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - FAILED: NO DATAS, NO RESPONSES & NO ERRORS
    
    func test_GetTranslation_Should_Post_Failed_Callback_NoData() {
        /// Given
        let translationService = TranslateService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        
        /// When
        let expectation = expectation(description: "Wait for queue change")
        translationService.getTranslation(for: "https://openclassrooms.com", target: "en", source: "fr") { result in
            
            /// then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - FAILED: INCORRECT RESPONSES
    
    func test_GetTranslation_Should_Post_Failed_Callback_If_Incorrect_Response() {
        /// Given
        let translationService = TranslateService(
            session: URLSessionFake(data: FakeTranslatorResponseData.translatorCorrectData, response: FakeTranslatorResponseData.responseKO, error: nil))
        
        /// When
        let expectation = expectation(description: "Wait for queue change")
        translationService.getTranslation(for: "https://openclassrooms.com", target: "en", source: "fr") { result in
            
            /// Then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - FAILED: INCORRECT DATAS
    
    func test_GetTranslation_Should_Post_Failed_Callback_If_Incorrect_Data() {
        /// Given
        let translationService = TranslateService(
            session: URLSessionFake(data: FakeTranslatorResponseData.translatorIncorrectData, response: FakeTranslatorResponseData.responseOK, error: nil))
        
        /// When
        let expectation = expectation(description: "Wait for queue change")
        translationService.getTranslation(for: "https://openclassrooms.com", target: "en", source: "fr") { result in
            
            /// Then
            XCTAssertNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // MARK: - SUCCESS : CORRECT DATAS & CORRECT RESPONSES
    
    func test_GetTranslation_Should_Post_Success_Callback_If_NoError_And_CorrectData() {
        /// Given
        let translationService = TranslateService(
            session: URLSessionFake(data: FakeTranslatorResponseData.translatorCorrectData, response: FakeTranslatorResponseData.responseOK, error: nil))
        
        /// When
        let expectation = expectation(description: "Wait for queue change")
        translationService.getTranslation(for: "https://openclassrooms.com", target: "en", source: "fr") { result in
            
            /// Then
            let translatedText = "Est-ce que vous connaissez Mickey?"
            
            XCTAssertNotNil(result)
            XCTAssertEqual(translatedText, result?.data.translations[0].translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
