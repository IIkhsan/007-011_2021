//
//  ViewController.swift
//  007-011_2021
//
//  Created by ilyas.ikhsanov on 20.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var words = [Word]()
    
    @IBOutlet weak var testWord: UILabel!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        //         FIXME: In last time should turn on onboarding view
        //                UserDefaults.standard.set(false, forKey: "isOldUser")
    }
    
    override func viewDidLayoutSubviews() {
        if !Core.shared.isOldUser() {
            let onboardingStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let viewController = onboardingStoryboard.instantiateViewController(withIdentifier: "OnboardingViewController")
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
        }
    }
    
    
}

class Core {
    static let shared = Core()
    
    func isOldUser() -> Bool {
        return UserDefaults.standard.bool(forKey: "isOldUser")
    }
    
    func setIsOldUser() {
        UserDefaults.standard.set(true, forKey: "isOldUser")
    }
}

