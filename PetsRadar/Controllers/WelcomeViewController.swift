//
//  ViewController.swift
//  PetsRadar
//
//  Created by Pelayo Mercado on 11/28/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
//        AuthManager.shared.exchangeCodeForToken { _ in
//            
//        }
     
        APICaller.shared.getAnimals { result in
            print(result)
        }
    }


}

