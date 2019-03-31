//
//  ArticlesService.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import Moya
import RxSwift

let requestTimeoutClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = TimeInterval(10)
        done(.success(request))
    } catch {
        let error = MoyaError.underlying(error, nil)
        done(.failure(error))
    }
}

func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data // fallback to original data if it can't be serialized.
    }
}

let ArticlesProvider = MoyaProvider<TopHeadlineAPI>(
    requestClosure: requestTimeoutClosure,
    plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)]
)

class ArticlesService {
    var provider: MoyaProvider<TopHeadlineAPI>
    
    init(provider: MoyaProvider<TopHeadlineAPI> = ArticlesProvider) {
        self.provider = provider
    }
    
    func fetch(_ parameters: FetchArticlesParameters) -> Single<ArticlesPage> {
        return provider.rx
            .request(.fetchArticles(parameters: parameters))
            .retry(3)
            .catchError { error in
                throw FetchArticlesError.serverError
            }
            .do(onSuccess: { response in
                if response.statusCode > 200 {
                    throw FetchArticlesError.permision
                }
            })
            .map(ArticlesPage.self)
    }
}
