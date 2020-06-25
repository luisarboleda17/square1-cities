//
//  MainCoordinator.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit
import RealmSwift

class MainCoordinator: Coordinator {
    internal var navigationController: UINavigationController!
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        loadCitiesList()
    }
    
    public func launchMap(results: Results<City>, query: String, page: Int) {
        loadCitiesMap(results: results, query: query, page: page)
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
    
    private func loadCitiesMap(results: Results<City>, query: String, page: Int) {
        OperationQueue.main.addOperation {
            let viewModel = CitiesMapViewModel(
                coordinator: self,
                citiesRepository: self.createCitiesRepository(),
                cities: results,
                query: query,
                currentPage: page
            )
            if let viewController = ViewModelLoader.loadView(
                viewControllerType: CitiesMapViewController.self,
                xibName: Xibs.citiesMap,
                viewModel: viewModel
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
