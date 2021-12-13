//
//  StartScreenViewController.swift
//  007-011_2021
//
//  Created by Тимур Миргалиев on 26.11.2021.
//

import UIKit
import SnapKit

class StartScreenViewController: UIViewController {

    let sayHelloLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let flag = true
        UserDefaults.standard.set(flag, forKey: "flag")
        view.addSubview(sayHelloLabel)
        sayHelloLabel.text = "Hi, "
        sayHelloLabel.numberOfLines = 0
        sayHelloLabel.snp.makeConstraints { maker in
            maker.top.equalTo(view).inset(30)
            maker.right.left.equalTo(view).inset(10)
        }
    }

    @IBAction func didClickContinueButton(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "onboarding")
        dismiss(animated: true)
    }
}
