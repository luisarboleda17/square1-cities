//
//  CitiesRepository.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/23/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation
import RealmSwift

enum CitiesSearchError {
    case connectionError
    case noResults
}

class CitiesRepository {
    private let apiClient: ApiClient!
    private let cacheManager: CacheManager!
    
    private let DEFAULT_CACHE_TTL: TimeInterval = 3600 // 1 hour cache
    
    required init(apiClient: ApiClient, cacheManager: CacheManager) {
        self.apiClient = apiClient
        self.cacheManager = cacheManager
    }
    
    public func search(withQuery query: String, page: Int, completion: @escaping (Results<City>?, Bool, CitiesSearchError?) -> Void) {
        if let results = cacheManager.getCacheableResults(forQuery: query, page: page, objectType: City.self),
            results.count > 0 {
            completion(results, false, nil)
        } else {
            apiClient.searchCities(withQuery: query, page: page) {
                response in
                if let response = response {
                    let cities: Array<City> = response.data.items.map {
                        city in
                        city.page = page
                        city.query = query
                        city.expiryDate = Date().addingTimeInterval(self.DEFAULT_CACHE_TTL)
                        return city
                    }
                    self.cacheManager.addCacheableElements(elements: cities, objectType: City.self)
                    
                    guard let results = self.cacheManager.getCacheableResults(forQuery: query, page: page, objectType: City.self) else {
                        return completion(nil, response.data.pagination.lastPage <= page, .noResults)
                    }
                    
                    completion(results, response.data.pagination.lastPage <= page, nil)
                } else {
                    completion(nil, false, CitiesSearchError.connectionError)
                }
            }
        }
    }
    
    public func getRecentQueries() -> Results<Query>? {
        return cacheManager.getRecentQueries()
    }
    
    public func addQuery(query: String) {
        cacheManager.addQuery(query: query)
    }
}
