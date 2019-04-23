//
//  TopHeadlineAPI.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import Moya

enum TopHeadlineAPI {
    case fetchArticles(parameters: FetchArticlesParameters)
}

extension TopHeadlineAPI: TargetType {
    var baseURL: URL {
        return Enviroment.baseURL
    }
    
    var path: String {
        return "top-headlines"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .fetchArticles(let parameters):
            return .requestParameters(parameters: parametersDictionary(from: parameters), encoding: URLEncoding(destination: .queryString))
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}

extension TopHeadlineAPI {
    private func parametersDictionary(from parameters: FetchArticlesParameters) -> [String: Any] {
        var parametersDictionary: [String: Any] = ["apiKey":parameters.apiKey]
        parametersDictionary["country"] = parameters.country
        if let category = parameters.category?.rawValue {
            parametersDictionary["category"] = category
        }
        if let page = parameters.page {
            parametersDictionary["page"] = page
        }
        if let pageSize = parameters.pageSize {
            parametersDictionary["pageSize"] = pageSize
        }
        return parametersDictionary
    }
}
