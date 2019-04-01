//
//  HomeModelGenerator.swift
//  Top HeadlineTests
//
//  Created by Giovane Silva de Menezes Cavalcante on 31/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import Foundation
@testable import Top_Headline

struct HomeModelGenerator {
    static func generateArticlesArray(amount: Int) -> [Article] {
        var articles = [Article]()
        for index in 0..<amount {
            let article = Article(title: "\(index)", author: "\(index)", url: "\(index)", urlToImage: "\(index)", publishedAt: "\(index)")
            articles.append(article)
        }
        return articles
    }
    
    static var fixedModel: HomeModel {
        return HomeModel(articles: generateArticlesArray(amount: 10), totalResults: 10, currentPage: 1, category: .general)
    }
}
