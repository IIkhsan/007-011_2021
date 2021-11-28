//
//  OnboardingViewController.swift
//  007-011_2021
//
//  Created by Семен Соколов on 28.11.2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        infoLabel.text = "This app helps people to remember English words. You can add your word to list and search new words that you don't know yet."
        infoLabel.sizeToFit()
        image.image = UIImage(named: "1")
    }
    
    @IBAction func startButton(_ sender: Any) {
        UserHelperService.shared.setIsNotNewUser()
        dismiss(animated: true)
    }
}
