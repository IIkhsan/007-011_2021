//
//  WelcomeViewController.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 24.11.2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - Properties
    var slides: [WelcomeSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    // MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [
            WelcomeSlide(title: "Welcome", description: "Welcome to dictionary app", image: #imageLiteral(resourceName: "welcome_0")),
            WelcomeSlide(title: "About us", description:  "The dictionary will help you learn new words. Easy to use - effective in learning.", image: #imageLiteral(resourceName: "icons8-literature-64")),
        ]
    
        pageControl.numberOfPages = slides.count
    }
    
    //MARK: - IBActions
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "TabBarController") as! UITabBarController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

//MARK: - WelcomeViewController
extension WelcomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WelcomeCollectionViewCell.identifier, for: indexPath) as! WelcomeCollectionViewCell
        cell.config(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
