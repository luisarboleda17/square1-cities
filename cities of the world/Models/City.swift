//
//  City.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/23/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation
import RealmSwift

class City: Cacheable, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String!
    @objc dynamic var localName: String!
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lng: Double = 0.0
    @objc dynamic var updatedAt: Date?
    @objc dynamic var countryName: String!
    @objc dynamic var continentName: String!
    @objc dynamic var page: Int = 0
    
    enum CityKeys: String, CodingKey {
        case id
        case name
        case localName = "local_name"
        case lat
        case lng
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case country
    }
    
    enum CountryKeys: String, CodingKey {
        case id
        case name
        case code
        case continent
    }
    
    enum ContinentKeys: String, CodingKey {
        case id
        case name
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    override class func indexedProperties() -> [String] {
        return ["expiryDate", "query", "page"]
    }
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let cityContainer = try decoder.container(keyedBy: CityKeys.self)
        self.id = try cityContainer.decode(Int.self, forKey: CityKeys.id)
        self.name = try cityContainer.decode(String.self, forKey: CityKeys.name)
        self.localName = try cityContainer.decode(String.self, forKey: CityKeys.localName)
        
        // Try to decode optional and especial attributes
        do {
            self.lat = try cityContainer.decode(Double.self, forKey: CityKeys.lat)
            self.lng = try cityContainer.decode(Double.self, forKey: CityKeys.lng)
        } catch _ as DecodingError {
            self.lat = 0.0
            self.lng = 0.0
        }
        
        // Try to decode date attributes
        do {
            let dateformatter = DateFormatter()
            let dateString = try cityContainer.decode(String.self, forKey: .updatedAt)
            
            dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            if let date = dateformatter.date(from: dateString) {
                self.updatedAt = date
            }
        } catch let error {
            print("Error decoding date")
            print(error)
        }
        
        let countryContainer = try cityContainer.nestedContainer(keyedBy: CountryKeys.self, forKey: CityKeys.country)
        self.countryName = try countryContainer.decode(String.self, forKey: CountryKeys.name)
        
        let continentContainer = try countryContainer.nestedContainer(keyedBy: ContinentKeys.self, forKey: CountryKeys.continent)
        self.continentName = try continentContainer.decode(String.self, forKey: ContinentKeys.name)
    }
    
    convenience init(
        id: Int,
        name: String,
        localName: String,
        lat: Double?,
        lng: Double?,
        updatedAt: Date,
        countryName: String,
        continentName: String,
        query: String,
        expiryDate: Date?,
        page: Int?
    ) {
        self.init()
        self.id = id
        self.name = name
        self.localName = localName
        self.lat = lat ?? 0.0
        self.lng = lng ?? 0.0
        self.updatedAt = updatedAt
        self.countryName = countryName
        self.continentName = continentName
        self.query = query
        self.page = page ?? 0
        
        if let expDate = expiryDate {
            self.expiryDate = expDate
        }
    }
}
