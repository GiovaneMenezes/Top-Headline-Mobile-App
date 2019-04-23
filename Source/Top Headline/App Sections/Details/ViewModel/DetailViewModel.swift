//
//  DetailViewModel.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 01/04/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import Foundation

class DetailViewModel {
    var path: String
    var title: String
    
    init(path: String, title: String) {
        self.path = path
        self.title = title
    }
    
    var articleURL: URL {
        return URL(string: path)!
    }
    
    var shareText: String {
        return "\(title) - \(path)"
    }
}
