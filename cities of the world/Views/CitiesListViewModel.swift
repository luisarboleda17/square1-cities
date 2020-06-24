//
//  CitiesListViewModel.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation

protocol CitiesListViewModelProtocol {
    
}

class CitiesListViewModel: BindableViewModel & CitiesListViewModelProtocol {
    typealias ViewDelegate = CitiesListViewDelegateProtocol
    
    internal var viewDelegate: ViewDelegate!
    private var coordinator: MainCoordinator!
    
    required init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
}
