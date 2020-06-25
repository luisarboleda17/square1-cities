//
//  CityLoadingCell.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/25/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

class CityLoadingCell: UITableViewCell {
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var subtitleView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleView.layer.cornerRadius = CGFloat(4.0)
        subtitleView.layer.cornerRadius = CGFloat(4.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
