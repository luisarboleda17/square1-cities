//
//  ViewController.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/22/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let cacheManager = CacheManager(
            storageConfiguration: Realm.Configuration.defaultConfiguration,
            inMemoryConfiguration: Realm.Configuration(inMemoryIdentifier: "cities")
        )
        
        print(cacheManager.getResults(forQuery: "panama", objectType: Cacheable.self))
    }


}

