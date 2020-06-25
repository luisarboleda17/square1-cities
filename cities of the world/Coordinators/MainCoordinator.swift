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
            let citiesRepository = CitiesRepository(
                apiClient: ApiClient(),
                cacheManager: CacheManager(storageConfiguration: DEFAULT_REALM_STORAGE_CCONFIGURATION, inMemoryConfiguration: DEFAULT_REALM_MEMORY_CONFIGURATION)
            )
            if let viewController = ViewModelLoader.loadView(
                viewControllerType: CitiesListViewController.self,
                xibName: Xibs.citiesList,
                viewModel: CitiesListViewModel(coordinator: self, citiesRepository: citiesRepository)
                ) {
                self.navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
}
