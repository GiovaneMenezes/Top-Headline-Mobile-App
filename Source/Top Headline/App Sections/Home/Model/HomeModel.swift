//
//  HomeModel.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import Foundation

struct HomeModel {
    var articles: [Article]
    var totalResults: Int
    var currentPage: Int
    var category: ArticleCategory
}
