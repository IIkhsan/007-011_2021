//
//  OnboardingViewController.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 22.11.2021.
//

import UIKit

class OnboardingViewController: UIViewController {
//    let networkService: NetworkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configure()
    }
    
    @IBAction func okayButtonAction(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier:  "SavedWordsViewController") as? SavedWordsViewController else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    //    private func getWord() {
//        DispatchQueue.global(qos: .userInitiated).async {
//            self.networkService.getWord { result in
//                switch result {
//                case .success(let word):
//                    print(word[0])
//
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
//    }
    
//    private func configure() {
//        guard let onboardingView = view as? OnboardingView else { return }
//    }
}
