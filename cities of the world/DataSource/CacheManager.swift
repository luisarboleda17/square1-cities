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
     Get cached cities for specific query
     */
    public func getResults<T: Cacheable>(forQuery query: String, objectType: T.Type) -> Results<T>? {
        do {
            let inMemoryRealm = try Realm(configuration: storageRealmConfiguration)
            let cacheFilter = NSPredicate(format: "expiryDate > %@ AND query == %@", NSDate(), query)
            let inMemoryResults = search(withRealm: inMemoryRealm, filter: cacheFilter, type: objectType)
            
            if (inMemoryResults.count > 0) {
                return inMemoryResults
            } else {
                let storageRealm = try Realm(configuration: inMemoryRealmConfiguration)
                let storageResults = search(withRealm: storageRealm, filter: cacheFilter, type: objectType)
                
                if (storageResults.count > 0) {
                    let removeForQueryFilter = NSPredicate(format: "query == %@", query)
                    inMemoryRealm.delete(search(withRealm: inMemoryRealm, filter: removeForQueryFilter, type: objectType))
                    for result in storageResults {
                        inMemoryRealm.create(objectType, value: result, update: Realm.UpdatePolicy.all)
                    }
                    return storageResults
                } else {
                    return nil
                }
            }
        } catch _ as NSError {
            return nil
        }
    }
}
