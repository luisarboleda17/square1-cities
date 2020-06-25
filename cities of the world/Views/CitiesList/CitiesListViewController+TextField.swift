//
//  CitiesListViewController+TextField.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

extension CitiesListViewController {
    @IBAction func onSearchSubmited(_ sender: UITextField) {
        searchSubmitted(query: sender.text)
        sender.endEditing(true)
    }
    
    @IBAction func onEditingChanged(_ sender: UITextField) {
        if sender.text == nil || sender.text == "" {
            searchCleared()
        }
    }
    
    private func searchQueryIsValid(query: String) -> Bool {
        guard query.count > 0 else {
            return false
        }
        return true
    }
    
    internal func searchSubmitted(query: String?) {
        guard let query = query, searchQueryIsValid(query: query) else {
            return searchCleared()
        }
        setViewForResults()
        viewModel.searchCities(query: query)
    }
    
    internal func searchCleared() {
        self.viewModel.clearSearch()
        self.viewModel.loadRecentQueries()
        setViewForRecentQueries()
    }
}

extension CitiesListViewController: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchCleared()
        return true
    }
}
