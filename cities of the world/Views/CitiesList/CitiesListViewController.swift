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

class CitiesListViewController: UIViewController & BindableViewDelegate {
    typealias ViewModel = CitiesListViewModelProtocol

    internal var viewModel: ViewModel!
    private let VIEW_TITLE = "Search a city"
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var recentQueriesLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureView() {
        configureNavigationBar()
        registerCityCell()
        searchField.setLeftIcon(imageName: "SearchIcon", verticalPadding: 12.0)
        searchField.setSearchStyle()
    }
    
    private func configureNavigationBar() {
        self.title = VIEW_TITLE
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "MapIcon"), style: .plain, target: self, action:  #selector(onMapIconTapped(sender:)))
    }
    
    private func registerCityCell() {
        citiesTableView.register(UINib(nibName: Xibs.cityCell, bundle: Bundle.main), forCellReuseIdentifier: Identifiers.cityCell)
        citiesTableView.register(UINib(nibName: Xibs.cityLoadingCell, bundle: Bundle.main), forCellReuseIdentifier: Identifiers.cityLoadingCell)
        citiesTableView.register(UINib(nibName: Xibs.recentQueryCell, bundle: Bundle.main), forCellReuseIdentifier: Identifiers.recentQueryCell)
    }
    
    @objc private func onMapIconTapped(sender: AnyObject?) {
        viewModel.launchMapResults()
    }
    
    internal func setViewForResults() {
        citiesTableView.allowsSelection = false
        recentQueriesLabel.text = "Results"
    }
    
    internal func setViewForRecentQueries() {
        citiesTableView.allowsSelection = true
        recentQueriesLabel.text = "Recent Queries"
    }
}
