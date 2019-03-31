//
//  FetchArticlesParameters.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import Foundation

struct FetchArticlesParameters: Codable {
    let category: ArticleCategory?
    let page: Int?
    let pageSize: Int?
    let apiKey: String
    let country = "us"
    
    init(category: ArticleCategory?, page: Int?, pageSize: Int?, apiKey: String) {
        self.category = category
        self.page = page
        self.pageSize = pageSize
        self.apiKey = apiKey
    }
}
