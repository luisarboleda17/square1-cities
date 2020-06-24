//
//  BindableViewDelegate.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

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

extension BindableViewDelegate where Self: UIViewController {
    /**
     Initialize view controller and bind view model
     */
    static func load<VM: BindableViewModel>(withXib xibName: String, viewModel: VM) -> Self where Self.ViewModel == VM {
        let viewController = Self.load(xibName: xibName)
        
        viewController.bind(viewModel)
        viewModel.bind(viewController as! VM.ViewDelegate)
        
        
        return viewController
    }
}
