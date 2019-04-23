//
//  Enviroment.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import Foundation

struct Enviroment {
    static var baseURL: URL {
        return URL(string: "https://newsapi.org/v2/")!
    }
    static var apiKey: String {
        return "0a30c22796004890a22d42bb0e697237"
    }
}
