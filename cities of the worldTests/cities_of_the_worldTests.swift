//
//  cities_of_the_worldTests.swift
//  cities of the worldTests
//
//  Created by Luis Arboleda on 6/22/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import XCTest
import RealmSwift
@testable import cities_of_the_world

class cities_of_the_worldTests: XCTestCase {
    
    func testCacheManager() throws {
        let cacheManager = CacheManager(
            storageConfiguration: Realm.Configuration.defaultConfiguration,
            inMemoryConfiguration: Realm.Configuration(inMemoryIdentifier: "cities")
        )
        
        XCTAssert(cacheManager.getResults(forQuery: "panama", objectType: Cacheable.self) != nil)
    }

}
