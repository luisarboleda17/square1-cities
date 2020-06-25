//
//  CitiesMapViewModel.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation
import RealmSwift

protocol CitiesMapViewModelProtocol {
    func mapsLoaded()
    func getCities() -> Results<City>
}

class CitiesMapViewModel: BindableViewModel & CitiesMapViewModelProtocol {
    typealias ViewDelegate = CitiesMapViewDelegateProtocol
    
    internal var viewDelegate: ViewDelegate!
    private var coordinator: MainCoordinator!
    private var citiesRepository: CitiesRepository!
    
    private var cities: Results<City>!
    private var query: String!
    private var currentPage: Int!
    
    required init(coordinator: MainCoordinator, citiesRepository: CitiesRepository, cities: Results<City>, query: String, currentPage: Int) {
        self.coordinator = coordinator
        self.citiesRepository = citiesRepository
        
        self.query = query
        self.cities = cities
        self.currentPage = currentPage
    }
    
    func mapsLoaded() {
        viewDelegate.citiesChanged()
    }
    
    func getCities() -> Results<City> {
        return cities
    }
}
