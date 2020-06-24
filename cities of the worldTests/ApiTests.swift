//
//  ApiTests.swift
//  cities of the worldTests
//
//  Created by Luis Arboleda on 6/23/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import XCTest
@testable import cities_of_the_world

class ApiTests: XCTestCase {
    let apiClient = ApiClient()
    let query = "pan"
    
    func testSearch() throws {
        let fetchExpectation = expectation(description: "Api Client returns data")
        
        apiClient.searchCities(withQuery: query, page: 1) {
            response in
            if (response != nil) {
                fetchExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
