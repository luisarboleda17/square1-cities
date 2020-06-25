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
}

class CitiesListViewModel: BindableViewModel & CitiesListViewModelProtocol {
    typealias ViewDelegate = CitiesListViewDelegateProtocol
    
    internal var viewDelegate: ViewDelegate!
    private var coordinator: MainCoordinator!
    private var citiesRepository: CitiesRepository!
    
    private var currentPage: Int = 1
    private var cities: Array<City> = []
    
    required init(coordinator: MainCoordinator, citiesRepository: CitiesRepository) {
        self.coordinator = coordinator
        self.citiesRepository = citiesRepository
    }
    
    func searchCities(query: String) {
        citiesRepository.search(withQuery: query, page: currentPage) {
            cities in
            self.cities = cities
            self.viewDelegate.citiesChanged()
        }
    }
    
    func getCitiesCount() -> Int {
        return cities.count
    }
    
    func getCity(forRow row: Int) -> City {
        return cities[row]
    }
}
