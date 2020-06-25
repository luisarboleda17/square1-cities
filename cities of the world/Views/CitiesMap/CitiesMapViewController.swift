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

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.mapsLoaded()
    }
    
    func citiesChanged() {
        viewModel.getCities().forEach {
            city in
            guard city.lat != 0, city.lng != 0 else {
                return
            }
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: city.lat, longitude: city.lng)
            marker.title = "Sydney"
            marker.snippet = "Australia"
            marker.map = self.mapsView
        }
    }
}
