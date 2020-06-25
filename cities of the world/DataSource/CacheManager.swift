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
     Remove all elements that match the query
     */
    private func delete<T: Cacheable>(withRealm realm: Realm, forQuery query: String, objectType: T.Type) throws {
        try realm.write {
            realm.delete(realm.objects(objectType).filter(NSPredicate(format: "query == %@", query)))
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
    public func getCacheableResults<T: Cacheable>(forQuery query: String, page: Int, objectType: T.Type) -> Results<T>? {
        do {
            let inMemoryRealm = try Realm(configuration: inMemoryRealmConfiguration)
            let validateCacheFilter = NSPredicate(format: "expiryDate > %@ AND query == %@ AND page == %d", NSDate(), query, page)
            let resultsFilter = NSPredicate(format: "query == %@ AND page <= %d", query, page)
            let result = inMemoryRealm.objects(objectType).filter(validateCacheFilter)
            
            // Valid cache
            if (result.count > 0) {
                return inMemoryRealm.objects(objectType).filter(resultsFilter)
            } else {
                let storageRealm = try Realm(configuration: storageRealmConfiguration)
                let storageResult = storageRealm.objects(objectType).filter(validateCacheFilter)
                
                // Valid cache
                if (storageResult.count > 0) {
                    let validResult = storageRealm.objects(objectType).filter(resultsFilter)
                    
                    try delete(withRealm: inMemoryRealm, forQuery: query, objectType: objectType) // delete in memory for this query
                    try copy(results: validResult, toRealm: inMemoryRealm, objectType: objectType) // copy
                    
                    return storageRealm.objects(objectType).filter(resultsFilter)
                } else {
                    return nil
                }
            }
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    /**
     Add elements to both databases
     */
    public func addCacheableElements<T: Cacheable>(elements: Array<T>, objectType: T.Type) {
        do {
            let inMemoryRealm = try Realm(configuration: inMemoryRealmConfiguration)
            let storageRealm = try Realm(configuration: storageRealmConfiguration)
            
            // Add to both, in-memory and storage database
            try inMemoryRealm.write { elements.forEach { inMemoryRealm.add($0, update: Realm.UpdatePolicy.modified) } }
            try storageRealm.write { elements.forEach { storageRealm.create(objectType, value: $0, update: Realm.UpdatePolicy.modified) } }
        } catch _ as NSError {}
    }
    
    public func getRecentQueries() -> Results<Query>? {
        do {
            let inMemoryRealm = try Realm(configuration: inMemoryRealmConfiguration)
            
            if let memoryQueries = getRecentQueries(forRealm: inMemoryRealm) {
                return memoryQueries
            } else {
                let storageRealm = try Realm(configuration: storageRealmConfiguration)
                if let storageQueries = getRecentQueries(forRealm: storageRealm) {
                    try inMemoryRealm.write {inMemoryRealm.deleteAll()}
                    try inMemoryRealm.write {storageQueries.forEach { inMemoryRealm.create(Query.self, value: $0, update: Realm.UpdatePolicy.modified) }}
                    
                    return getRecentQueries(forRealm: inMemoryRealm)
                } else {
                    return nil
                }
            }
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    public func addQuery(query: String) {
        do {
            let inMemoryRealm = try Realm(configuration: inMemoryRealmConfiguration)
            let storageRealm = try Realm(configuration: storageRealmConfiguration)
            
            // Create query object
            let queryObject = Query()
            queryObject.query = query
            queryObject.createdAt = Date()
            
            // Add to both, in-memory and storage database
            try inMemoryRealm.write {inMemoryRealm.add(queryObject, update: .modified)}
            try storageRealm.write {storageRealm.create(Query.self, value: queryObject, update: .modified)}
        } catch _ as NSError {}
    }
    
    private func getRecentQueries(forRealm realm: Realm) -> Results<Query>? {
        let queries = realm.objects(Query.self).sorted(byKeyPath: "createdAt", ascending: false)
        if (queries.count > 0) {
            return queries
        } else {
            return nil
        }
    }
    
}
