//
//  ViewModelLoader.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

class ViewModelLoader {
    static func loadView<VD: UIViewController & BindableViewDelegate, VM: BindableViewModel>(viewControllerType: VD.Type, xibName: String, viewModel: VM) -> VD? {
        let viewController = VD.load(xibName: xibName)
        viewController.bind(viewModel as! VD.ViewModel)
        viewModel.bind(viewController as! VM.ViewDelegate)
        return viewController
    }
}
