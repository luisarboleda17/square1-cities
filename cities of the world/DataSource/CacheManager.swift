//
//  CacheManager.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/23/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation
import RealmSwift

class CacheManager {
    final let storageRealmConfiguration: Realm.Configuration!
    final let inMemoryRealmConfiguration: Realm.Configuration!
    
    init(storageConfiguration: Realm.Configuration, inMemoryConfiguration: Realm.Configuration) {
        self.storageRealmConfiguration = storageConfiguration
        self.inMemoryRealmConfiguration = inMemoryConfiguration
    }
    
    /**
     Search in realm with a query
     */
    private func search<T: Cacheable>(withRealm realm: Realm, filter: NSPredicate, type: T.Type) -> Results<T> {
        return realm.objects(type).filter(filter)
    }
    
    /**
     Remove all elements that match the query
     */
    private func delete<T: Cacheable>(withRealm realm: Realm, forQuery query: String, objectType: T.Type) throws {
        try realm.write {
            realm.delete(
                search(
                    withRealm: realm,
                    filter: NSPredicate(format: "query == %@", query),
                    type: objectType
                )
            )
        }
    }
    
    /**
     Copy results from one realm to another realm
     */
    private func copy<T: Cacheable>(results: Results<T>, toRealm realm: Realm, objectType: T.Type) throws {
        try realm.write {
            results.forEach { realm.create(objectType, value: $0, update: Realm.UpdatePolicy.all) }
        }
    }
    
    /**
     Get cached cities for specific query
     */
    public func getResults<T: Cacheable>(forQuery query: String, objectType: T.Type) -> Results<T>? {
        do {
            let inMemoryRealm = try Realm(configuration: inMemoryRealmConfiguration)
            let cacheFilter = NSPredicate(format: "expiryDate > %@ AND query == %@", NSDate(), query)
            let inMemoryResults = search(withRealm: inMemoryRealm, filter: cacheFilter, type: objectType)
            
            if (inMemoryResults.count > 0) {
                return inMemoryResults
            } else {
                let storageRealm = try Realm(configuration: storageRealmConfiguration)
                let storageResults = search(withRealm: storageRealm, filter: cacheFilter, type: objectType)
                
                if (storageResults.count > 0) {
                    try delete(withRealm: inMemoryRealm, forQuery: query, objectType: objectType)
                    try copy(results: storageResults, toRealm: inMemoryRealm, objectType: objectType)
                    return storageResults
                } else {
                    return nil
                }
            }
        } catch _ as NSError {
            return nil
        }
    }
    
    public func setElements<T: Cacheable>(elements: Array<T>, objectType: T.Type) {
        do {
            let inMemoryRealm = try Realm(configuration: inMemoryRealmConfiguration)
            let storageRealm = try Realm(configuration: storageRealmConfiguration)
        } catch _ as NSError {}
    }
}
