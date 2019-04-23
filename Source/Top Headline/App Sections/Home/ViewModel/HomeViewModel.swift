//
//  HomeViewModel.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    var model = HomeModel(articles: [], totalResults: 0, currentPage: 1, category: .general)
    var articleServer: ArticlesService?
    
    var disposeBag = DisposeBag()
    
    var isLoading: Observable<Bool> = Observable(false)
    var isErrored: Observable<String?> = Observable(nil)
    var newsCellModels: Observable<[NewsCollectionViewCell.Model]> = Observable([])
    var isFetching: Bool = false
    
    init() {
        articleServer = ArticlesService()
    }
    
    var nextPageAvailable: Bool {
        return model.totalResults > model.articles.count
    }
    
    var fetchParameters: FetchArticlesParameters {
        return FetchArticlesParameters(category: model.category,
                                       page: model.currentPage,
                                       pageSize: 10,
                                       apiKey: Enviroment.apiKey)
    }
    
    func generateCellModel(from article: Article) -> NewsCollectionViewCell.Model {
        return NewsCollectionViewCell.Model(title: article.title ?? " ",
                                            author: article.author ?? " ",
                                            urlToImage: article.urlToImage ?? " ",
                                            publishedAt: formatDateString(article.publishedAt ?? " "))
    }
    
    func formatDateString(_ publishedAt: String?) -> String? {
        guard let publishedAt = publishedAt else { return nil }
        let publishedAtSpilitted = publishedAt.split(separator: "T")
        return String(publishedAtSpilitted[0])
    }
    
    func fetchArcticle() {
        isFetching = true
        articleServer?
            .fetch(fetchParameters)
            .subscribe { [weak self] response in
                guard let self = self else { return }
                self.isFetching = false
                switch response {
                case .success(let element):
                    self.isLoading.value = false
                    self.isErrored.value = nil
                    self.model.totalResults = element.totalResults ?? 0
                    if let articles = element.articles {
                        self.model.articles.append(contentsOf: articles)
                        self.newsCellModels.value.append(contentsOf: articles.map { self.generateCellModel(from: $0) })
                    }
                    self.model.currentPage += 1
                case .error(let error):
                    self.isLoading.value = false
                    self.isErrored.value = error.localizedDescription
                }
            }.disposed(by: disposeBag)
    }
    
    func onArticleDidSelected(index: Int) {
        delegate?.didSelectedArticle(title: model.articles[index].title ?? "", path: model.articles[index].url ?? "")
    }
}
