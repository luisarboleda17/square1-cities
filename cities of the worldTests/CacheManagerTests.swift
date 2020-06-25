//
//  cities_of_the_worldTests.swift
//  cities of the worldTests
//
//  Created by Luis Arboleda on 6/22/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Cities_of_the_World

class CacheManagerTests: XCTestCase {
    private var storeConfiguration: Realm.Configuration!
    private var inMemoryConfiguration: Realm.Configuration!
    private var cacheManager: CacheManager!
    
    override func setUp() {
        super.setUp()
        
        // Set Realm configurations
        self.storeConfiguration = Realm.Configuration(inMemoryIdentifier: "\(self.name)-storage")
        self.inMemoryConfiguration = Realm.Configuration(inMemoryIdentifier: "\(self.name)-memory")
        self.cacheManager = CacheManager(storageConfiguration: storeConfiguration, inMemoryConfiguration: inMemoryConfiguration)
    }
    
    private func clearDatabase() throws {
        let inMemoryRealm = try Realm(configuration: inMemoryConfiguration)
        let storageRealm = try Realm(configuration: storeConfiguration)
        try inMemoryRealm.write { inMemoryRealm.deleteAll() }
        try storageRealm.write { storageRealm.deleteAll() }
    }
    
    func testGetResultsInvalidMemoryAndStorageValid() throws {
        try clearDatabase()
        
        // Create realms
        let inMemoryRealm = try Realm(configuration: inMemoryConfiguration)
        let storageRealm = try Realm(configuration: storeConfiguration)
        let query = "panama"
        let page = 1
        
        // Add in memory default values
        try inMemoryRealm.write {
            inMemoryRealm.add(
                City(
                    id: 1,
                    name: "Panama",
                    localName: "Panama",
                    lat: nil,
                    lng: nil,
                    updatedAt: Date(),
                    countryName: "Panama",
                    continentName: "America",
                    query: query,
                    expiryDate: Date().addingTimeInterval(-1 * 5 * 60), // 5 minutes before -> Expired
                    page: page
                )
            )
        }
        
        // Add storage default values
        try storageRealm.write {
            storageRealm.add(
                City(
                    id: 1,
                    name: "Panama",
                    localName: "Panama",
                    lat: nil,
                    lng: nil,
                    updatedAt: Date(),
                    countryName: "Panama",
                    continentName: "America",
                    query: query,
                    expiryDate: Date().addingTimeInterval(5 * 60), // 5 minutes after -> Not Expired
                    page: page
                )
            )
            storageRealm.add(
                City(
                    id: 2,
                    name: "Bogota",
                    localName: "Bogota",
                    lat: nil,
                    lng: nil,
                    updatedAt: Date(),
                    countryName: "Colombia",
                    continentName: "America",
                    query: query,
                    expiryDate: Date().addingTimeInterval(5 * 60), // 5 minutes after -> Not Expired
                    page: page
                )
            )
        }
        
        // Validate
        let results = cacheManager.getResults(forQuery: query, page: page, objectType: City.self)
        XCTAssertNotNil(results)
        
        if let results = results {
            XCTAssert(results.count == 2)
        }
    }
    
    func testGetResultsValidMemory() throws {
        try clearDatabase()
        
        // Create realms
        let inMemoryRealm = try Realm(configuration: inMemoryConfiguration)
        let storageRealm = try Realm(configuration: storeConfiguration)
        let query = "panama"
        let page = 1
        
        // Add in memory default values
        try inMemoryRealm.write {
            inMemoryRealm.add(
                City(
                    id: 1,
                    name: "Panama",
                    localName: "Panama",
                    lat: nil,
                    lng: nil,
                    updatedAt: Date(),
                    countryName: "Panama",
                    continentName: "America",
                    query: query,
                    expiryDate: Date().addingTimeInterval(5 * 60), // 5 minutes before -> Expired
                    page: page
                )
            )
        }
        
        // Add storage default values
        try storageRealm.write {
            storageRealm.add(
                City(
                    id: 1,
                    name: "Panama",
                    localName: "Panama",
                    lat: nil,
                    lng: nil,
                    updatedAt: Date(),
                    countryName: "Panama",
                    continentName: "America",
                    query: query,
                    expiryDate: Date().addingTimeInterval(5 * 60), // 5 minutes after -> Not Expired
                    page: page
                )
            )
            storageRealm.add(
                City(
                    id: 2,
                    name: "Bogota",
                    localName: "Bogota",
                    lat: nil,
                    lng: nil,
                    updatedAt: Date(),
                    countryName: "Colombia",
                    continentName: "America",
                    query: query,
                    expiryDate: Date().addingTimeInterval(5 * 60), // 5 minutes after -> Not Expired
                    page: page
                )
            )
        }
        
        // Validate
        let results = cacheManager.getResults(forQuery: query, page: page, objectType: City.self)
        XCTAssertNotNil(results)
        
        if let results = results {
            XCTAssert(results.count == 1, "\(results.count) results")
        }
    }
    
    func testGetResultsInvalidStorage() throws {
        try clearDatabase()
        
        // Create realms
        let storageRealm = try Realm(configuration: storeConfiguration)
        let query = "panama"
        let page = 1
        
        // Add storage default values
        try storageRealm.write {
            storageRealm.add(
                City(
                    id: 1,
                    name: "Panama",
                    localName: "Panama",
                    lat: nil,
                    lng: nil,
                    updatedAt: Date(),
                    countryName: "Panama",
                    continentName: "America",
                    query: query,
                    expiryDate: Date().addingTimeInterval(-1 * 5 * 60), // 5 minutes before -> Expired
                    page: page
                )
            )
            storageRealm.add(
                City(
                    id: 2,
                    name: "Bogota",
                    localName: "Bogota",
                    lat: nil,
                    lng: nil,
                    updatedAt: Date(),
                    countryName: "Colombia",
                    continentName: "America",
                    query: query,
                    expiryDate: Date().addingTimeInterval(-1 * 5 * 60), // 5 minutes after -> Expired
                    page: page
                )
            )
        }
        
        // Validate
        let results = cacheManager.getResults(forQuery: query, page: page, objectType: City.self)
        XCTAssertNil(results)
    }
    
    func testAddElements() throws {
        try clearDatabase()
        
        let query = "panama"
        let page = 1
        
        cacheManager.addElements(
            elements: [
                City(
                    id: 1,
                    name: "Panama",
                    localName: "Panama",
                    lat: nil,
                    lng: nil,
                    updatedAt: Date(),
                    countryName: "Panama",
                    continentName: "America",
                    query: query,
                    expiryDate: Date().addingTimeInterval(5 * 60), // 5 minutes before -> Valid
                    page: page
                ),
                City(
                    id: 2,
                    name: "Bogota",
                    localName: "Bogota",
                    lat: nil,
                    lng: nil,
                    updatedAt: Date(),
                    countryName: "Colombia",
                    continentName: "America",
                    query: query,
                    expiryDate: Date().addingTimeInterval(5 * 60), // 5 minutes after -> Valid
                    page: page
                ),
                City(
                    id: 3,
                    name: "Medellin",
                    localName: "Medellin",
                    lat: nil,
                    lng: nil,
                    updatedAt: Date(),
                    countryName: "Colombia",
                    continentName: "America",
                    query: query,
                    expiryDate: Date().addingTimeInterval(5 * 60), // 5 minutes before -> Valid
                    page: page
                )
            ],
            objectType: City.self
        )
        
        let results = cacheManager.getResults(forQuery: query, page: page, objectType: City.self)
        XCTAssertNotNil(results)
        
        if let results = results {
            XCTAssert(results.count == 3)
        }
    }
}
