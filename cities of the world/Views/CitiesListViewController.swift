//
//  TestViewController.swift
//  cities of the world
//
//  Created by Luis Arboleda on 6/24/20.
//  Copyright © 2020 Luis Arboleda. All rights reserved.
//

import UIKit

protocol CitiesListViewDelegateProtocol {
    
}

class CitiesListViewController<VM: CitiesListViewModelProtocol & BindableViewModel>: UIViewController & BindableViewDelegate & CitiesListViewDelegateProtocol {
    typealias ViewModel = VM

    internal var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Initi the view")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
