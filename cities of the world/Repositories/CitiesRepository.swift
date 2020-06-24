//
//  CitiesRepository.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/23/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation

class CitiesRepository {
    private let apiClient: ApiClient!
    private let cacheManager: CacheManager!
    
    private let DEFAULT_CACHE_TTL: TimeInterval = 3600 // 1 hour cache
    
    required init(apiClient: ApiClient, cacheManager: CacheManager) {
        self.apiClient = apiClient
        self.cacheManager = cacheManager
    }
    
    public func search(withQuery query: String, page: Int, completion: @escaping (Array<City>) -> Void) {
        if let results = cacheManager.getResults(forQuery: query, page: page, objectType: City.self),
            results.count > 0 {
            print("Cargo de caché")
            completion(Array(results))
        } else {
            apiClient.searchCities(withQuery: query, page: page) {
                response in
                if let response = response {
                    print(response)
                    print("Cargo de internet")
                    
                    let cities: Array<City> = response.data.items.map{
                        city in
                        city.page = page
                        city.query = query
                        city.expiryDate = Date().addingTimeInterval(self.DEFAULT_CACHE_TTL)
                        return city
                    }
                    self.cacheManager.addElements(elements: cities, objectType: City.self)
                    completion(cities)
                } else {
                    print("No hay nada en internet")
                }
            }
        }
    }
    
}
