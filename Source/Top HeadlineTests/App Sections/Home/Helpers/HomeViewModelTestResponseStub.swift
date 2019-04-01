//
//  HomeViewModelTestResponseStub.swift
//  Top HeadlineTests
//
//  Created by Giovane Silva de Menezes Cavalcante on 31/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import Foundation

enum HomeViewModelTestResponseStub {
    case successResponse
    case failureResponse
}

extension HomeViewModelTestResponseStub {
    var data: Data! {
        switch self {
        case .failureResponse:
            return """
                {
                    "status": "error",
                    "code": "apiKeyMissing",
                    "message": "Your API key is missing. Append this to the URL with the apiKey param, or use the x-api-key HTTP header."
                }
            """.data(using: .utf8)
        case .successResponse:
            guard let path = Bundle.main.path(forResource: "SuccessfulArticlesReceived", ofType: "json") else { return Data() }
            return try! String(contentsOfFile: path).data(using: .utf8)
        }
    }
}

extension HomeViewModelTestResponseStub {
    var responseCode: Int {
        switch self {
        case .failureResponse: return 401
        case .successResponse: return 200
        }
    }
}
