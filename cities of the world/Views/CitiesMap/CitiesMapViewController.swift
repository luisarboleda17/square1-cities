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
    }
    
    func citiesChanged() {
        // Creates a marker in the center of the map.
        /*
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView*/
    }
}
