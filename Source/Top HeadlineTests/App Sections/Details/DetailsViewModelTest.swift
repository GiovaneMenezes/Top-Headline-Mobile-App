//
//  DetailsViewModelTest.swift
//  Top HeadlineTests
//
//  Created by Giovane Silva de Menezes Cavalcante on 01/04/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import Top_Headline

class DetailsViewModelTest: XCTestCase {
    
    var sut: DetailViewModel!
    
    override func setUp() {
        super.setUp()
        sut = DetailViewModel(path: "", title: "")
    }
    
    func testGeneratingCorrectMessage() {
        sut.path = "http://google.com"
        sut.title = "google"
        XCTAssertEqual(sut.shareText, "google - http://google.com", "should return title - url")
    }
}
