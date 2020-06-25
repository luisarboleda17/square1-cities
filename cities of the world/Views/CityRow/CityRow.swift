//
//  CityRow.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

class CityRow: UITableViewCell {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var continentNameLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    var cityName: String? {
        get {
            return cityNameLabel.text
        }
        set(newCity) {
            cityNameLabel.text = newCity
        }
    }
    var countryName: String? {
        get {
            return countryNameLabel.text
        }
        set(newCountry) {
            countryNameLabel.text = newCountry
        }
    }
    
    var continentName: String? {
        get {
            return continentNameLabel.text
        }
        set(newContinent) {
            continentNameLabel.text = newContinent
        }
    }
    
    var separatorVisible: Bool {
        get {
            return !separatorView.isHidden
        }
        set(visible) {
            separatorView.isHidden = !visible
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
