//
//  OnboardingViewController.swift
//  007-011_2021
//
//  Created by Семен Соколов on 28.11.2021.
//

import UIKit

class OnboardingViewController: UIViewController {

    //MARK: - UI
    @IBOutlet var holderView: UIView!
    let scrollView = UIScrollView()
    
    //MARK: - View controller's cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }
    
    //MARK: - Private function
    private func configure() {
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        let titles = ["Welcome to dictionary", "Information", "Subscribe to my instagram!"]
        for onboarding in 0..<3 {
            let pageView = UIView(frame: CGRect(x: CGFloat (onboarding) * (holderView.frame.size.width), y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.size.width-20, height: 120))
            let imageView = UIImageView(frame: CGRect(x: 10, y: 10+120+10, width: pageView.frame.size.width-20, height: pageView.frame.size.height - 60 - 130 - 15))
            label.textAlignment = .center
            label.font = UIFont(name: label.font.fontName, size: 23)
            pageView.addSubview(label)
            label.text = titles[onboarding]
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "onboarding_\(onboarding+1)")
            pageView.addSubview(imageView)
            if onboarding == 2 {
                let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height-60, width: pageView.frame.size.width-20, height: 50))
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .black
                button.setTitle("Get started", for: .normal)
                button.tag = onboarding+1
                button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
                pageView.addSubview(button)
            }
        }
        scrollView.contentSize = CGSize(width: holderView.frame.size.width*3, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    //MARK: - Button action
    @objc func didTapButton (_ button: UIButton) {
        guard button.tag < 3 else {
            UserHelperService.shared.setIsNotNewUser()
            dismiss(animated: true)
            return
        }
    }
}
