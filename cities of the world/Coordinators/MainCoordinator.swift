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
    
    public func launchMap(forQuery query: String) {
        loadCitiesMap(forQuery: query)
    }
    
    private func loadCitiesList() {
        OperationQueue.main.addOperation {
            if let viewController = ViewModelLoader.loadView(
                viewControllerType: CitiesListViewController.self,
                xibName: Xibs.citiesList,
                viewModel: CitiesListViewModel(coordinator: self, citiesRepository: self.createCitiesRepository())
                ) {
                self.navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
    
    private func loadCitiesMap(forQuery query: String) {
        OperationQueue.main.addOperation {
            if let viewController = ViewModelLoader.loadView(
                viewControllerType: CitiesMapViewController.self,
                xibName: Xibs.citiesMap,
                viewModel: CitiesMapViewModel(coordinator: self, citiesRepository: self.createCitiesRepository(), query: query)
                ) {
                self.navigationController.pushViewController(viewController, animated: true)
            }
        }
    }
    
    private func createCitiesRepository() -> CitiesRepository {
        return CitiesRepository(
            apiClient: ApiClient(),
            cacheManager: CacheManager(storageConfiguration: DEFAULT_REALM_STORAGE_CCONFIGURATION, inMemoryConfiguration: DEFAULT_REALM_MEMORY_CONFIGURATION)
        )
    }
}
