//
//  ApiClient.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/23/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation
import Alamofire

struct ApiResponse<T: Decodable>: Decodable {
    struct Data<T: Decodable>: Decodable {
        let items: Array<T>
        let pagination: PaginationResult
    }
    
    let data: Data<T>
    let time: Int
}

class ApiClient {
    let API_PREFIX = "http://connect-demo.mobile1.io/square1/connect/v1/city"
    let SEARCH_FILTER_KEY = "filter[0][name][contains]"
    let INCLUDE_CONTINENT_VALUE = "country.continent"
    let RESULTS_PER_PAGE = 15
    
    func searchCities(withQuery query: String, page: Int = 1, completion: @escaping (ApiResponse<City>?) -> Void) {
        AF.request(
            API_PREFIX,
            method: .get,
            parameters: [
                SEARCH_FILTER_KEY: query,
                "include": INCLUDE_CONTINENT_VALUE,
                "page": page,
                "per_page": RESULTS_PER_PAGE
            ]
        ).responseDecodable(of: ApiResponse<City>.self) {
            response in
            if let responseValue = response.value {
                completion(responseValue)
            } else {
                completion(nil)
            }
        }
    }
}
