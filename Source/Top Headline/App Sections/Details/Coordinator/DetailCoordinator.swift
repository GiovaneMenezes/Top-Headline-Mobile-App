//
//  DetailCoordinator.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 01/04/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import UIKit

class DetailCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var detailViewController: DetailViewController?
    private let path: String
    private let title: String
    
    init(presenter: UINavigationController, title: String, path: String) {
        self.presenter = presenter
        self.path = path
        self.title = title
    }
    
    func start() {
        let detailViewController = DetailViewController(nibName: nil, bundle: nil)
        detailViewController.title = "Article"
        detailViewController.viewModel = DetailViewModel(path: path, title: title)
        presenter.pushViewController(detailViewController, animated: true)
    }
}
