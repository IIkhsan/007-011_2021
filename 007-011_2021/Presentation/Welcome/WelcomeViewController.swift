//
//  WelcomeViewController.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 24.11.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var holderView: UIView!
    
    let scrollView = UIScrollView()
    
    // MARK: -  View Life cycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        config()
    }
    
    //Private functions
    private func config() {
        
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        
        let titles = ["Welcome", "About app"]
        
        for i in 0..<2 {
            let pageView = UIView(frame: CGRect(x: CGFloat(i) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            
            // Title, image, button
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.width-20, height: 120))
            let text = UILabel(frame: CGRect(x: 10, y: 140, width: pageView.frame.width-20, height: pageView.frame.size.height - 205))
            let imageView = UIImageView(frame: CGRect(x: 10, y: 140, width: pageView.frame.width-20, height: pageView.frame.size.height - 205))
            let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height-60, width: pageView.frame.width-20, height: 50))
            
            label.textAlignment = .center
            label.font = UIFont(name: "Helvetica-Bold", size: 32)
            pageView.addSubview(label)
            label.text = titles[i]
            label.textColor = .purple
            
            if i == 0 {
                imageView.contentMode = .scaleAspectFit
                imageView.image = UIImage(named: "welcome_0")
            }
            pageView.addSubview(imageView)
            
            if i == 1 {
                text.textAlignment = .center
                text.font = UIFont(name: "Helvetica", size: 25)
                pageView.addSubview(label)
                text.text = "Our dictionary will help you learn new English words. Easy to use - effective in action"
            }
            pageView.addSubview(text)
            
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .purple
            button.setTitle("Continue", for: .normal)
            if i == 1 {
                button.setTitle("Start", for: .normal)
            }
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            button.tag = i+1
            pageView.addSubview(button)
        }
        scrollView.contentSize = CGSize(width: holderView.frame.size.width*3, height: 0)
        scrollView.isPagingEnabled = true
    }
    
    //objc func
    @objc func didTapButton(_ button: UIButton) {
        guard button.tag < 2 else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        // scroll to next page
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
    }
}
