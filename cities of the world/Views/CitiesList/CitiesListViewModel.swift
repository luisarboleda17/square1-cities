//
//  CitiesListViewModel.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation
import RealmSwift

protocol CitiesListViewModelProtocol {
    var fetchingCities: Bool { get }
    
    func searchCities(query: String)
    func loadMoreCities()
    
    func getCitiesCount() -> Int
    func getCity(forRow row: Int) -> City?
    
    func launchMapResults()
}

class CitiesListViewModel: BindableViewModel & CitiesListViewModelProtocol {
    typealias ViewDelegate = CitiesListViewDelegateProtocol
    
    internal var viewDelegate: ViewDelegate!
    private var coordinator: MainCoordinator!
    private var citiesRepository: CitiesRepository!
    
    var fetchingCities: Bool = false
    private var cities: Results<City>?
    private var currentPage: Int = 1
    private var query: String?
    
    required init(coordinator: MainCoordinator, citiesRepository: CitiesRepository) {
        self.coordinator = coordinator
        self.citiesRepository = citiesRepository
    }
    
    func searchCities(query: String) {
        self.query = query
        self.currentPage = 1
        self.fetchingCities = true
        self.viewDelegate.citiesChanged()
        citiesRepository.search(withQuery: query, page: currentPage) {
            (cities, error) in
            if let cities = cities {
                self.cities = cities
                self.fetchingCities = false
                self.viewDelegate.citiesChanged()
            } else {
                print("Error getting results")
            }
        }
    }
    
    func loadMoreCities() {
        if let query = query {
            self.currentPage += 1
            self.fetchingCities = true
            self.viewDelegate.citiesChanged()
            citiesRepository.search(withQuery: query, page: currentPage) {
                (cities, error) in
                if let cities = cities {
                    self.cities = cities
                    self.fetchingCities = false
                    self.viewDelegate.citiesChanged()
                } else {
                    print("Error getting results")
                }
            }
        }
    }
    
    func getCitiesCount() -> Int {
        return cities?.count ?? 0
    }
    
    func getCity(forRow row: Int) -> City? {
        return cities?[row]
    }
    
    func launchMapResults() {
        if let query = query, let cities = cities {
            coordinator.launchMap(results: cities, query: query, page: currentPage)
        }
    }
}
