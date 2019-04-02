//
//  HomeCoordinator.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var homeViewController: HomeViewController?
    private var detailCoordinator: DetailCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let homeViewController = HomeViewController(nibName: nil, bundle: nil)
        homeViewController.title = "Home"
        let homeViewModel = HomeViewModel()
        homeViewModel.delegate = self
        homeViewController.viewModel = homeViewModel
        presenter.pushViewController(homeViewController, animated: true)
        self.homeViewController = homeViewController
    }
}

extension HomeCoordinator: HomeViewModelDelegate {
    func didSelectedArticle(title: String, path: String) {
        let detailCoordinator = DetailCoordinator(presenter: presenter, title: title, path: path)
        self.detailCoordinator = detailCoordinator
        detailCoordinator.start()
    }
}
