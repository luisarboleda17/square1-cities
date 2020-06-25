//
//  CitiesListViewController+TextField.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

extension CitiesListViewController {
    @IBAction func searchSubmited(_ sender: UITextField) {
        onSearchSubmitted(query: sender.text)
        sender.endEditing(true)
    }
    
    private func searchQueryIsValid(query: String) -> Bool {
        guard query.count > 0 else {
            return false
        }
        return true
    }
    
    private func onSearchSubmitted(query: String?) {
        guard let query = query, searchQueryIsValid(query: query) else {
            return
        }
        viewModel.searchCities(query: query)
    }
}
