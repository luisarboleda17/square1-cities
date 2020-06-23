//
//  City.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/23/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation
import RealmSwift

class City: Cacheable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String!
    @objc dynamic var localName: String!
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lng: Double = 0.0
    @objc dynamic var updatedAt: Date?
    @objc dynamic var countryName: String!
    @objc dynamic var continentName: String!
    
    convenience init(
        id: Int,
        name: String,
        localName: String,
        lat: Double,
        lng: Double,
        updatedAt: Date,
        countryName: String,
        continentName: String,
        query: String,
        expiryDate: Date?
    ) {
        self.init()
        self.id = id
        self.name = name
        self.localName = localName
        self.lat = lat
        self.lng = lng
        self.updatedAt = updatedAt
        self.countryName = countryName
        self.continentName = continentName
        self.query = query
        
        if let expDate = expiryDate {
            self.expiryDate = expDate
        }
    }
}
