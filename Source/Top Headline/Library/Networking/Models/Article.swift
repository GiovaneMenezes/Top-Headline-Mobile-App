//
//  Article.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import Foundation

struct Article: Codable {
    let title: String?
    let author: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}
