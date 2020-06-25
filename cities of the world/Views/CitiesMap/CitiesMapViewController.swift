//
//  CitiesMapViewController.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit
import GoogleMaps

protocol CitiesMapViewDelegateProtocol {
    func citiesChanged()
}

class CitiesMapViewController: UIViewController & BindableViewDelegate & CitiesMapViewDelegateProtocol {
    typealias ViewModel = CitiesMapViewModelProtocol
    
    var viewModel: CitiesMapViewModelProtocol!
    
    @IBOutlet weak var mapsView: GMSMapView!
    @IBOutlet weak var searchField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchToolbar()
        viewModel.mapsLoaded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureSearchToolbar() {
        searchField.setLeftIcon(imageName: "SearchIcon", horizontalPadding: 16, verticalPadding: 12)
        searchField.setSearchStyle()
        searchField.text = viewModel.getQuery()
    }
    
    func citiesChanged() {
        viewModel.getCities().forEach {
            city in
            guard city.lat != 0, city.lng != 0 else {
                return
            }
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: city.lat, longitude: city.lng)
            marker.title = city.name
            marker.snippet = city.countryName
            marker.map = self.mapsView
        }
    }
}
