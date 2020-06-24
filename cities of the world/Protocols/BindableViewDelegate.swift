//
//  BindableViewDelegate.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import Foundation

protocol BindableViewDelegate: class {
    associatedtype ViewModel
    
    var viewModel: ViewModel! { get set }
    
    func bind(_ viewModel: ViewModel)
}

extension BindableViewDelegate {
    func bind(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
