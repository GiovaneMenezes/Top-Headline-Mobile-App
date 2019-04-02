//
//  DetailViewController.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 01/04/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        guard let viewModel = viewModel else { return }
        let request = URLRequest(url: viewModel.articleURL)
        webView.load(request)
    }
    
    func setupNavigationBar() {
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func shareButtonTapped() {
        guard let viewModel = viewModel else { return }
        let activityController = UIActivityViewController(activityItems: [viewModel.shareText], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = view
        self.present(activityController, animated: true)
    }
}
