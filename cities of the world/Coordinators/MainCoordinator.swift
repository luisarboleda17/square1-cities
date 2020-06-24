//
//  MainCoordinator.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    internal var navigationController: UINavigationController!
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        loadCitiesList()
    }
    
    private func loadCitiesList() {
        OperationQueue.main.addOperation {
            if let viewController = ViewModelLoader.loadView(
                viewControllerType: CitiesListViewController.self,
                xibName: Xibs.citiesList,
                viewModel: CitiesListViewModel(coordinator: self)
                ) {
                self.navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
}
