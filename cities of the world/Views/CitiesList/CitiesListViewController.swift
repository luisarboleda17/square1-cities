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
    private let VIEW_TITLE = "Cities of the world"
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var citiesTableView: UITableView!
    
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
    }
    
    @objc private func onMapIconTapped(sender: AnyObject?) {
        viewModel.launchMapResults()
    }
}
