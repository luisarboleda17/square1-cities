//
//  SceneDelegate+Coordinator.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

extension SceneDelegate {
    internal func loadCoordinator(windowScene: UIWindowScene) {
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        let navigationController = UINavigationController()
        let coordinator = MainCoordinator(navigationController: navigationController)
        
        self.window = window
        self.window?.windowScene = windowScene
        self.window?.rootViewController = navigationController
        self.mainCoordinator = coordinator

        coordinator.start()
        window.makeKeyAndVisible()
    }
}
