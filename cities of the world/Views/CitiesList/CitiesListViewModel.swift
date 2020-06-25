//
//  CitiesListViewModel.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation

protocol CitiesListViewModelProtocol {
    func searchCities(query: String)
    
    func getCitiesCount() -> Int
    func getCity(forRow row: Int) -> City
    
    func launchMapResults()
}

class CitiesListViewModel: BindableViewModel & CitiesListViewModelProtocol {
    typealias ViewDelegate = CitiesListViewDelegateProtocol
    
    internal var viewDelegate: ViewDelegate!
    private var coordinator: MainCoordinator!
    private var citiesRepository: CitiesRepository!
    
    private var searchState: CitiesSearchState = CitiesSearchState(page: 1, query: nil, results: [])
    
    required init(coordinator: MainCoordinator, citiesRepository: CitiesRepository) {
        self.coordinator = coordinator
        self.citiesRepository = citiesRepository
    }
    
    func searchCities(query: String) {
        self.searchState.query = query
        citiesRepository.search(withQuery: query, page: searchState.page) {
            cities in
            self.searchState.results.append(contentsOf: cities)
            self.viewDelegate.citiesChanged()
        }
    }
    
    func getCitiesCount() -> Int {
        return searchState.results.count
    }
    
    func getCity(forRow row: Int) -> City {
        return searchState.results[row]
    }
    
    func launchMapResults() {
        coordinator.launchMap(withSearchState: searchState)
    }
}
