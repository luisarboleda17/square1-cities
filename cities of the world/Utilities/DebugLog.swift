//
//  DebugLog.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/23/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation

/**
 Log to console only if is in debug scheme
 */
func log(_ text: String) {
    #if DEBUG
        print(text)
    #endif
}

/**
 Log with a custom tag
 */
func log(_ tag: String, _ message: String) {
    log("\(tag): \(message)")
}
