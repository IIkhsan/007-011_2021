//
//  OnboardingViewController.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 22.11.2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    let networkService: NetworkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
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
    
    private func configure() {
        guard let onboardingView = view as? OnboardingView else { return }
    }
}
