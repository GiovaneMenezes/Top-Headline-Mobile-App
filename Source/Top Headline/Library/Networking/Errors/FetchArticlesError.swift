//
//  FetchArticlesError.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import Foundation

enum FetchArticlesError {
    case serverError
    case permision
}

extension FetchArticlesError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .serverError:
            return "Something weird happened! Try again later..."
        case .permision:
            return "Sorry, my authentication has failed"
        }
    }
}
