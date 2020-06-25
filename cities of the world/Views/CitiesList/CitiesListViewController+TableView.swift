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
        return viewModel.fetchingCities ? 5 : viewModel.getCitiesCount() // If loading, show 5 elements
    }
}

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (viewModel.fetchingCities) {
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.cityLoadingCell, for: indexPath) as! CityLoadingCell
            return cell
        } else {
            let city = viewModel.getCity(forRow: indexPath.row)!
            let lastCity = indexPath.row == viewModel.getCitiesCount() - 1
            let cityRow = tableView.dequeueReusableCell(withIdentifier: Identifiers.cityCell, for: indexPath) as! CityRow
            return createCityCell(
                row: cityRow,
                cityName: city.name,
                countryName: city.countryName,
                continentName: city.continentName,
                separatorVisible: !lastCity
            )
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    private func createCityCell(row: CityRow, cityName: String, countryName: String, continentName: String, separatorVisible: Bool) -> CityRow {
        row.cityName = cityName
        row.countryName = countryName
        row.continentName = continentName
        row.separatorVisible = separatorVisible
        return row
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = viewModel.getCitiesCount() - 1
        if indexPath.row == lastElement && !viewModel.fetchingCities {
            viewModel.loadMoreCities()
        }
    }
}
