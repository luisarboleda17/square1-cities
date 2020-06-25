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
        return 3
    }
}

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cityRow = tableView.dequeueReusableCell(withIdentifier: Identifiers.cityCell, for: indexPath) as? CityRow else {
            return createCityCell(row: CityRow(), cityName: "Test", countryName: "Test", continentName: "Test")
        }
        return createCityCell(row: cityRow, cityName: "test 1", countryName: "Test 2", continentName: "Test 3")
    }
    
    private func createCityCell(row: CityRow, cityName: String, countryName: String, continentName: String) -> CityRow {
        row.cityName = "City test"
        row.countryName = "Country test"
        row.continentName = "Continent test"
        return row
    }
}
