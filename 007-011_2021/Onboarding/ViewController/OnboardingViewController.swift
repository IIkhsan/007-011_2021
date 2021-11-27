//
//  OnboardingViewController.swift
//  007-011_2021
//
//  Created by Alexandr Onischenko on 27.11.2021.
//

import UIKit

class OnboardingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK:- outlets for the viewController
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var getStartedButton: UIButton!
    
    // data for the Onboarding Screens
    let pages: [Page] = [Page(animationName: "animation-1", title: "Learn to Code", description: "Find awesome tutorials on how to code and improve your coding practices"),
                         Page(animationName: "animation-2", title: "Code with Friends", description: "Practice with friends and solve problems together to earn points"),
                         Page(animationName: "animation-3", title: "Always there to Help", description: "Having Trouble? Get guidance from our experienced Mentors")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to make the button rounded
        self.getStartedButton.layer.cornerRadius = 20
        
        // register the custom CollectionViewCell and assign the delegates to the ViewController
        self.collectionView.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "OnboardingCollectionViewCell", bundle: Bundle.main),
                                     forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
        
        // set the number of pages to the number of Onboarding Screens
        self.pageControl.numberOfPages = self.pages.count
    }
    
    // MARK:- outlet functions for the viewController
    @IBAction func pageChanged(_ sender: Any) {
        let pc = sender as! UIPageControl
        
        // scrolling the collectionView to the selected page
        collectionView.scrollToItem(at: IndexPath(item: pc.currentPage, section: 0),
                                    at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        Core.shared.setIsOldUser()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK:- collectionView dataSource & collectionView FlowLayout delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell",
                                                      for: indexPath) as! OnboardingCollectionViewCell
        // function for configuring the cell, defined in the Custom cell class
        cell.configureCell(page: pages[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    // to update the UIPageControl
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
