//
//  BindableViewDelegate.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

protocol BindableViewDelegate: class {
    associatedtype ViewModel: BindableViewModel
    
    var viewModel: ViewModel! { get set }
    
    func bind(_ viewModel: ViewModel)
}

extension BindableViewDelegate {
    func bind(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

extension BindableViewDelegate where Self: UIViewController {
    /**
     Initialize view controller and bind view model
     */
    static func load(withXib xibName: String, viewModel: ViewModel) -> ViewModel.ViewDelegate? {
        let viewController = Self.load(xibName: xibName)
        
        if let viewDelegate = viewController as? ViewModel.ViewDelegate {
            viewController.bind(viewModel)
            viewModel.bind(viewDelegate)
            return viewDelegate
        } else {
            return nil
        }
    }
}
