//
//  BindableViewModel.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation

protocol BindableViewModel: class {
    associatedtype ViewDelegate
    
    var viewDelegate: ViewDelegate! { get set }
    
    func bind(_ viewDelegate: ViewDelegate)
}

extension BindableViewModel {
    func bind(_ viewDelegate: ViewDelegate) {
        self.viewDelegate = viewDelegate
    }
}
