//
//  CitiesListViewController.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

protocol CitiesListViewDelegateProtocol {
}

class CitiesListViewController: UIViewController & BindableViewDelegate & CitiesListViewDelegateProtocol {
    typealias VM = CitiesListViewModelProtocol
    
    internal var viewModel: VM!
    
}
