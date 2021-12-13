//
//  StartScreenViewController.swift
//  007-011_2021
//
//  Created by Тимур Миргалиев on 26.11.2021.
//

import UIKit
import SnapKit

class StartScreenViewController: UIViewController {

    //MARK: - UI
    private let sayHelloLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let continueButton = UIButton(type: .system)
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    /// Assigns the right values to the UI
    private func configure() {
        sayHelloLabel.text = "🎉 Welcome!"
        sayHelloLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(sayHelloLabel)
        sayHelloLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(150)
            maker.left.equalToSuperview().inset(50)
        }
        descriptionLabel.text = "This app is designed for learning English, you could call it an explanatory dictionary. Here you can find the spelling of a word and its history and listen to how it is pronounced."
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.top.equalTo(sayHelloLabel).inset(50)
        }
        continueButton.backgroundColor = UIColor(red: 84/255, green: 118/255, blue: 171/255, alpha: 1)
        continueButton.setTitle("Start learning!!!", for: .normal)
        continueButton.layer.cornerRadius = 20
        continueButton.setTitleColor(.white, for: .normal)
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(30)
        }
        continueButton.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)
        
    }
    
    /// Set onboarding flag to UserDefaults
    @objc private func didClickButton() {
        UserDefaults.standard.set(false, forKey: "StartScreen")
        dismiss(animated: true)
    }
}
