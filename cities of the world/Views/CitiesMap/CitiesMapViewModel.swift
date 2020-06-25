//
//  CitiesMapViewModel.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation

protocol CitiesMapViewModelProtocol {
    func loadCities()
}

class CitiesMapViewModel: BindableViewModel & CitiesMapViewModelProtocol {
    typealias ViewDelegate = CitiesMapViewDelegateProtocol
    
    internal var viewDelegate: ViewDelegate!
    private var coordinator: MainCoordinator!
    private var citiesRepository: CitiesRepository!
    
    private var currentPage: Int = 1
    private var cities: Array<City> = []
    private var query: String!
    
    required init(coordinator: MainCoordinator, citiesRepository: CitiesRepository, query: String) {
        self.coordinator = coordinator
        self.citiesRepository = citiesRepository
        self.query = query
    }
    
    func loadCities() {
        citiesRepository.search(withQuery: self.query, page: currentPage) {
            cities in
            self.cities = cities
            self.viewDelegate.citiesChanged()
        }
    }
}
