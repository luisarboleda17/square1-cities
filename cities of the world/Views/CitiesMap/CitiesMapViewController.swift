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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    func citiesChanged() {
        
    }
}
