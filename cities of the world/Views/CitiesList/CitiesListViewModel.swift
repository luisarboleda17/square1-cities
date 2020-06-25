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
    var fetchingMoreCities: Bool { get }
    var shouldLoadMore: Bool { get }
    var queryExists: Bool { get }
    
    func searchCities(query: String)
    func loadMoreCities()
    func clearSearch()
    
    func loadRecentQueries()
    
    func getCitiesCount() -> Int
    func getCity(forRow row: Int) -> City?
    
    func getRecentQueriesCount() -> Int
    func getRecentQuery(forRow row: Int) -> String
    
    func launchMapResults()
}

class CitiesListViewModel: BindableViewModel & CitiesListViewModelProtocol {
    typealias ViewDelegate = CitiesListViewDelegateProtocol
    
    internal var viewDelegate: ViewDelegate!
    private var coordinator: MainCoordinator!
    private var citiesRepository: CitiesRepository!
    
    private var MAX_QUERIES_LIMIT = 7
    
    internal var fetchingCities: Bool = false
    internal var fetchingMoreCities: Bool = false
    internal var shouldLoadMore: Bool = true
    internal var queryExists: Bool {
        get {
            return self.query != nil
        }
    }
    private var cities: Results<City>?
    private var currentPage: Int = 1
    private var query: String?
    private var recentQueries: Results<Query>?
    
    required init(coordinator: MainCoordinator, citiesRepository: CitiesRepository) {
        self.coordinator = coordinator
        self.citiesRepository = citiesRepository
    }
    
    func searchCities(query: String) {
        self.query = query
        self.currentPage = 1
        self.fetchingCities = true
        self.shouldLoadMore = true
        self.viewDelegate.citiesChanged()
        self.citiesRepository.addQuery(query: query)
        self.citiesRepository.search(withQuery: query, page: self.currentPage) {
            cities, lastPage, error in
            
            guard let cities = cities, error == nil else {
                self.fetchingCities = false
                if (error == CitiesSearchError.noResults) {
                    self.shouldLoadMore = !lastPage
                }
                self.viewDelegate.citiesChanged()
                return
            }
            self.cities = cities
            self.fetchingCities = false
            self.shouldLoadMore = !lastPage
            
            self.viewDelegate.citiesChanged()
        }
    }
    
    func loadMoreCities() {
        if let query = query {
            self.currentPage += 1
            self.fetchingMoreCities = true
            self.shouldLoadMore = false
            self.citiesRepository.search(withQuery: query, page: self.currentPage) {
                cities, lastPage, error in
                
                guard let cities = cities, error == nil else {
                    self.fetchingMoreCities = false
                    if (error == CitiesSearchError.noResults) {
                        self.shouldLoadMore = !lastPage
                    }
                    self.viewDelegate.citiesChanged()
                    return
                }
                self.cities = cities
                self.fetchingMoreCities = false
                self.shouldLoadMore = !lastPage
                
                self.viewDelegate.citiesChanged()
            }
        }
    }
    
    func clearSearch() {
        self.cities = nil
        self.currentPage = 1
        self.query = nil
        self.viewDelegate.citiesChanged()
    }
    
    func getCitiesCount() -> Int {
        return cities?.count ?? 0
    }
    
    func getCity(forRow row: Int) -> City? {
        return cities?[row]
    }
    
    func loadRecentQueries() {
        if let recentQueries = citiesRepository.getRecentQueries() {
            self.recentQueries = recentQueries
            self.viewDelegate.citiesChanged()
        }
    }
    
    func getRecentQueriesCount() -> Int {
        if let recentQueries = self.recentQueries {
            let queriesCount = recentQueries.count
            return queriesCount <= MAX_QUERIES_LIMIT ? queriesCount : MAX_QUERIES_LIMIT
        } else {
            return 0
        }
    }
    
    func getRecentQuery(forRow row: Int) -> String {
        return recentQueries?[row].query ?? ""
    }
    
    func launchMapResults() {
        if let query = query, let cities = cities {
            coordinator.launchMap(results: cities, query: query, page: currentPage)
        }
    }
}
