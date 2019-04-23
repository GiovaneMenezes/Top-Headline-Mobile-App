//
//  ArcticleCategory.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import Foundation

enum ArticleCategory: String, Codable {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}

extension ArticleCategory {
    static let allValues = [business, entertainment, general, health, science, sports, technology]
    var title: String { return self.rawValue }
}
