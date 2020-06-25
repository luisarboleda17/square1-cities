//
//  CitiesListViewController+ViewDelegate.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation

extension CitiesListViewController: CitiesListViewDelegateProtocol {
    internal func citiesChanged() {
        OperationQueue.main.addOperation {
            self.citiesTableView.reloadData()
            if (!self.viewModel.fetchingCities && self.viewModel.queryExists) {
                self.recentQueriesLabel.text = "\(self.viewModel.getCitiesCount()) results"
            }
        }
    }
}
