//
//  ViewController.swift
//  007-011_2021
//
//  Created by ilyas.ikhsanov on 20.11.2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    // MARK: - button action
    @IBAction func closeOnboarding(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "onboarding")
        dismiss(animated: true)
        
    }

}

