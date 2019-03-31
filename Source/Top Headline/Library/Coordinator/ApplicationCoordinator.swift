//
//  ApplicationCoordinator.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {
    let rootViewController: UINavigationController
    let window: UIWindow
    let homeCoordinator: HomeCoordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        homeCoordinator = HomeCoordinator(presenter: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        homeCoordinator.start()
        window.makeKeyAndVisible()
    }
}
