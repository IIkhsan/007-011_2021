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
        view.addSubview(sayHelloLabel)
        sayHelloLabel.text = ""
        sayHelloLabel.numberOfLines = 0
        sayHelloLabel.snp.makeConstraints { maker in
            maker.top.equalTo(view).inset(30)
            maker.right.left.equalTo(view).inset(10)
        }
    }
}
