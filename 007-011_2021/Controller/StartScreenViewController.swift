//
//  StartScreenViewController.swift
//  007-011_2021
//
//  Created by Илья Желтиков on 15.12.2021.
//
import SnapKit
import UIKit

class StartScreenViewController: UIViewController {

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let continueButton = UIButton(type: .system)
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        /// Верстка снизу-сверх, т.к. расположение элементов снизу относительно экрана
        /// Button
        continueButton.backgroundColor = UIColor.systemBlue
        continueButton.setTitle("Okeeey, let's goo", for: .normal)
        continueButton.layer.cornerRadius = 15
        continueButton.setTitleColor(.white, for: .normal)
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(30)
        }
        continueButton.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)
        
        /// Description
        descriptionLabel.text = "This app designed by beginner iOS developer for the puprose of learning different words in English. We hope for your understanding and feedback."
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview().inset(25)
            maker.bottom.equalTo(continueButton).inset(60)
        }
        
        /// Title
        titleLabel.text = "Dictionary"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.bottom.equalTo(descriptionLabel).inset(100)
            maker.left.equalToSuperview().inset(25)
            
        }
    }
    
    /// Onboarding using UserDefaults
    @objc private func didClickButton() {
        UserDefaults.standard.set(false, forKey: "Onboarding")
        dismiss(animated: true)
    }

}
