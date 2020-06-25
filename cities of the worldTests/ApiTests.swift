//
//  ApiTests.swift
//  cities of the worldTests
//
//  Created by Luis Arboleda on 6/23/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import XCTest
@testable import Cities_of_the_World

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
    
    func testSearchPagination() throws {
        let currentPage = 2
        let pageFetchExpectation = expectation(description: "Api client returned page correctly")
        
        apiClient.searchCities(withQuery: query, page: currentPage) {
            response in
            guard let response = response else {
                return
            }
            if (response.data.pagination.currentPage == currentPage) {
                pageFetchExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
