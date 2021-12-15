//
//  TapBarController.swift
//  007-011_2021
//
//  Created by Marat Giniyatov on 12.12.2021.
//

import UIKit

class TapBarController: UITabBarController {
    
    
    override func viewWillAppear(_ animated: Bool) {
           checkOnboarding()
    }
    
    // MARK: - check to see is onboarding already showed or not
    private func checkOnboarding() {
        if UserDefaults.standard.value(forKey: "onboarding") == nil{
            let viewController = storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController
            present(viewController ?? UIViewController(), animated: true)
        }
    }

    



}
