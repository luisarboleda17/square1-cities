//
//  Query.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/25/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation
import RealmSwift

class Query: Object {
    @objc dynamic var query: String!
    
    override class func primaryKey() -> String? {
        return "query"
    }
}
