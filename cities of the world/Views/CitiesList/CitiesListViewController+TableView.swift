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
        if (viewModel.fetchingCities) {
            return 5 // 5 elements of loading
        } else if (viewModel.queryExists) {
            return viewModel.getCitiesCount()
        } else {
            return viewModel.getRecentQueriesCount()
        }
    }
}

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (viewModel.fetchingCities) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.cityLoadingCell, for: indexPath) as! CityLoadingCell
            return cell
        } else if (viewModel.queryExists) {
            
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
        } else {
            
            let recentQuery = viewModel.getRecentQuery(forRow: indexPath.row)
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.recentQueryCell, for: indexPath) as! RecentQueryCell
            cell.query = recentQuery
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.queryExists ? 68 : 44
    }
    
    private func createCityCell(row: CityRow, cityName: String, countryName: String, continentName: String, separatorVisible: Bool) -> CityRow {
        row.cityName = cityName
        row.countryName = countryName
        row.continentName = continentName
        row.separatorVisible = separatorVisible
        return row
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (!viewModel.fetchingCities && !viewModel.fetchingMoreCities && viewModel.shouldLoadMore) {
            if (indexPath.row == viewModel.getCitiesCount() - 6) {
                viewModel.loadMoreCities()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (!viewModel.queryExists) {
            let recentQuery = viewModel.getRecentQuery(forRow: indexPath.row)
            self.searchField.text = recentQuery
            searchSubmitted(query: recentQuery)
        }
    }
}
