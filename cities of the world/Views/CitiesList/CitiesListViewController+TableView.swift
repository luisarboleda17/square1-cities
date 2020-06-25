//
//  CitiesListViewController+TableView.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

extension CitiesListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCitiesCount()
    }
}

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let city = viewModel.getCity(forRow: indexPath.row)
        let lastCity = indexPath.row == viewModel.getCitiesCount() - 1
        
        guard let cityRow = tableView.dequeueReusableCell(withIdentifier: Identifiers.cityCell, for: indexPath) as? CityRow else {
            return createCityCell(row: CityRow(), cityName: city.name, countryName: city.countryName, continentName: city.continentName, separatorVisible: !lastCity)
        }
        return createCityCell(
            row: cityRow,
            cityName: city.name,
            countryName: city.countryName,
            continentName: city.continentName,
            separatorVisible: !lastCity
        )
    }
    
    private func createCityCell(row: CityRow, cityName: String, countryName: String, continentName: String, separatorVisible: Bool) -> CityRow {
        row.cityName = cityName
        row.countryName = countryName
        row.continentName = continentName
        row.separatorVisible = separatorVisible
        return row
    }
}
