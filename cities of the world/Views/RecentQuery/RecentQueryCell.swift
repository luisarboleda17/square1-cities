//
//  RecentQueryCell.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/25/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

class RecentQueryCell: UITableViewCell {
    
    @IBOutlet internal weak var recentQueryLabel: UILabel!
    
    public var query: String? {
        get { return recentQueryLabel.text }
        set(newQuery) { recentQueryLabel.text = newQuery }
    }
}
