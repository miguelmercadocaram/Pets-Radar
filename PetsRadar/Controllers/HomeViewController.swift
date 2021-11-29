//
//  HomeViewController.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 11/29/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemCyan
        APICaller.shared.getAnimals { result in
            print(result)
        }
    }
    


}
