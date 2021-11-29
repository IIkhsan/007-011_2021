//
//  OnboardingViewController.swift
//  007-011_2021
//
//  Created by Даниил Багаутдинов on 28.11.2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Button
    
    @IBAction func continueButton(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "onboarding")
        dismiss(animated: true)
    }
}
