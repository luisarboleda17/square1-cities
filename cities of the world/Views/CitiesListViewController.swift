//
//  TestViewController.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

protocol CitiesListViewDelegateProtocol {
    func citiesChanged()
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
        viewModel.searchCities(query: "Pan")
    }
    
    private func configureView() {
        configureNavigationBar()
        registerCityCell()
        searchField.setLeftIcon(imageName: "SearchIcon", verticalPadding: 12.0)
        searchField.setSearchStyle()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = VIEW_TITLE
    }
    
    private func registerCityCell() {
        citiesTableView.register(UINib(nibName: Xibs.cityCell, bundle: Bundle.main), forCellReuseIdentifier: Identifiers.cityCell)
    }
    
    internal func citiesChanged() {
        self.citiesTableView.reloadData()
    }
    
    
    @IBAction func searchEditingEnd(_ sender: UITextField) {
        onSearchSubmitted(query: sender.text)
    }
    
    
    @IBAction func searchSubmited(_ sender: UITextField) {
        onSearchSubmitted(query: sender.text)
    }
    
    private func searchQueryIsValid(query: String) -> Bool {
        guard query.count > 0 else {
            return false
        }
        return true
    }
    
    private func onSearchSubmitted(query: String?) {
        guard let query = query, searchQueryIsValid(query: query) else {
            return
        }
        viewModel.searchCities(query: query)
    }
}
