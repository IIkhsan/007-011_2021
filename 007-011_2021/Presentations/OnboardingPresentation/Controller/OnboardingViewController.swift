//
//  OnboardingViewController.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 06.12.2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: - VC properties
    let localDataManager = PersistableService.shared
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if localDataManager.isOnboarded() {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "NavigationController") as? UINavigationController else { return }
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
    }
    
    //MARK: - IBActions
    @IBAction func nextButtonPressed(_ sender: Any) {
        localDataManager.setOnboarded()
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else { return }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
}


