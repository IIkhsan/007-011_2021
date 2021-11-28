//
//  SavedWordsViewController.swift
//  007-011_2021
//
//  Created by Семен Соколов on 24.11.2021.
//

import UIKit

class SavedWordsViewController: UIViewController {
    
    //MARK: - Dependencies
    let networkService = NetworkService()
    
    //MARK: - View controller's cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UserHelperService.shared.isNewUser() {
            let vc = storyboard?.instantiateViewController(withIdentifier: "onboarding") as! OnboardingViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}
