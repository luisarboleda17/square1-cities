//
//  TestViewController.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

protocol CitiesListViewDelegateProtocol {
    
}

class CitiesListViewController: UIViewController & BindableViewDelegate & CitiesListViewDelegateProtocol {
    typealias ViewModel = CitiesListViewModelProtocol

    internal var viewModel: ViewModel!
    private let VIEW_TITLE = "Cities of the world"
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var citiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        configureNavigationBar()
        searchField.setLeftIcon(imageName: "SearchIcon", verticalPadding: 12.0)
        searchField.setSearchStyle()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = VIEW_TITLE
    }
}
