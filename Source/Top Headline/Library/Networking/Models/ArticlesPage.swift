//
//  ArticlesPage.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import Foundation

struct ArticlesPage: Codable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
}
