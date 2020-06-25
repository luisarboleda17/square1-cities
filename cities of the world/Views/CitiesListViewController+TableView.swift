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
        return 0
    }
}

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
