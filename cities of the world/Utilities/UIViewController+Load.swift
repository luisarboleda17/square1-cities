//
//  UIViewController+Load.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     Load view controller from xib name
     */
    static func load(xibName: String) -> Self {
        return Self.init(nibName: xibName, bundle: Bundle.main)
    }
}
