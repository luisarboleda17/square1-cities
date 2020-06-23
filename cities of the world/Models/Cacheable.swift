//
//  Cacheable.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/23/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation
import RealmSwift

class Cacheable: Object {
    @objc dynamic var expiryDate: Date!
    @objc dynamic var query: String!
}
