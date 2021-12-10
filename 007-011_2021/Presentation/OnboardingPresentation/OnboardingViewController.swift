//
//  OnboardingViewController.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 22.11.2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // private properties
    private let userDefaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        print(userDefaults.bool(forKey: "isFirstRun"))
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func okayButtonAction(_ sender: Any) {
        userDefaults.set(true, forKey: "isFirstRun")
        makeNavigation()
    }
    
    // private functions
    private func makeNavigation() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier:  "SavedWordsViewController") as? SavedWordsViewController else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func configure() {
        if userDefaults.bool(forKey: "isFirstRun") {
            userDefaults.set(true, forKey: "isFirstRun")
            makeNavigation()
        }
    }
}
