//
//  ViewController.swift
//  007-011_2021
//
//  Created by ilyas.ikhsanov on 20.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: -  View Life cycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "welcome") as! WelcomeViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

