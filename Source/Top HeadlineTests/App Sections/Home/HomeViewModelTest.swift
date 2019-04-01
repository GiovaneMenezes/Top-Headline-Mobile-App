//
//  HomeViewModelTest.swift
//  Top HeadlineTests
//
//  Created by Giovane Silva de Menezes Cavalcante on 31/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import Top_Headline

class HomeViewModelTest: XCTestCase {
    var sut: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        sut = HomeViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    func testIfNextPageIsAvailable() {
        sut.model = HomeModelGenerator.fixedModel
        sut.model.articles = HomeModelGenerator.generateArticlesArray(amount: 10)
        XCTAssertFalse(sut.nextPageAvailable, "should return false")
        
        sut.model.articles = HomeModelGenerator.generateArticlesArray(amount: 9)
        XCTAssertTrue(sut.nextPageAvailable, "should return true")
    }
    
    func testIfResquestParametersAreCorrect() {
        sut.model = HomeModelGenerator.fixedModel
        let requestParameters = sut.fetchParameters
        XCTAssertEqual(requestParameters.category, sut.model.category,  "Should be equal")
        XCTAssertEqual(requestParameters.page, sut.model.currentPage, "Should be equal")
        XCTAssertEqual(requestParameters.apiKey, Enviroment.apiKey, "should be equal")
        XCTAssertEqual(requestParameters.country, "us", "should be US")
        XCTAssertEqual(requestParameters.pageSize, 10, "should be 10")
    }
    
    func testIfIsGeneratingCorrectCellModels() {
        sut.model = HomeModelGenerator.fixedModel
        sut.model.articles = HomeModelGenerator.generateArticlesArray(amount: 5)
        let cellModel = sut.generateCellModel(from: sut.model.articles[1])
        XCTAssertEqual(cellModel.author, sut.model.articles[1].author, "should be equal")
        XCTAssertEqual(cellModel.publishedAt, sut.model.articles[1].publishedAt, "should be equal")
        XCTAssertEqual(cellModel.title, sut.model.articles[1].title, "should be equal")
        XCTAssertEqual(cellModel.urlToImage, sut.model.articles[1].urlToImage, "should be equal")
    }
    
    func testIfLoadingIsDismissedWhenResponseIsReceived() {
        stubRequests(with: .successResponse)
        let validation = expectation(description: "ErrorResponseReceived")
        sut.model = HomeModelGenerator.fixedModel
        sut.isLoading.didChange = { value in
            XCTAssertFalse(value, "should disable the loading observable")
            validation.fulfill()
        }
        sut.fetchArcticle()
        waitForExpectations(timeout: 10)
    }
    
    func testIfErrorAppearWhenAFailirureResponseReceived() {
        stubRequests(with: .failureResponse)
        let validation = expectation(description: "ErrorResponseReceived")
        sut.model = HomeModelGenerator.fixedModel
        sut.isErrored.didChange = { value in
            XCTAssertNotNil(value, "should have a error message")
            validation.fulfill()
        }
        sut.fetchArcticle()
        waitForExpectations(timeout: 10)
    }
    
    func testIfErrorAppearWhenASuccessfulResponseReceived() {
        stubRequests(with: .successResponse)
        let validation = expectation(description: "SuccessResponseReceived")
        sut.model = HomeModelGenerator.fixedModel
        sut.isErrored.didChange = { value in
            XCTAssertNil(value, "shouldn't have a error message")
            validation.fulfill()
        }
        sut.fetchArcticle()
        waitForExpectations(timeout: 10)
    }
    
    func testDecodingResponse() {
        stubRequests(with: .successResponse)
        let validation = expectation(description: "SuccessResponseReceived")
        sut.model = HomeModelGenerator.fixedModel
        sut.newsCellModels.didChange { response in
            XCTAssertEqual(sut.newsCellModels.value.count, 10, "It's a full page, should present 10 articles")
            validation.fulfill()
        }
        sut.fetchArcticle()
        waitForExpectations(timeout: 10)
    }
}

extension HomeViewModelTest {
    func stubRequests(with response: HomeViewModelTestResponseStub) {
        stub(condition: isHost("newsapi.org")) { _ -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(data: response.data, statusCode: Int32(response.responseCode), headers: nil)
        }
    }
}
