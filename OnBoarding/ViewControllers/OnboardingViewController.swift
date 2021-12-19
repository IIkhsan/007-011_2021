//
//  OnboardingViewController.swift
//  007-011_2021
//
//  Created by andrewoch on 09.12.2021.
//

import UIKit

class OnboardingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Outlets for the viewController
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var getStartedButton: UIButton!
    
    // MARK: - Data for the Onboarding Screens
    let pages: [Page] = [Page(title: "Learn to Code", description: "Find awesome tutorials on how to code and improve your coding practices"),
                         Page(title: "Code with Friends", description: "Practice with friends and solve problems together to earn points"),
                         Page(title: "Always there to Help", description: "Having Trouble? Get guidance from our experienced Mentors")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOnboarding()
    }
    
    func configureOnboarding() {
        self.getStartedButton.layer.cornerRadius = 20
        
        self.collectionView.backgroundColor = .white
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "OnboardingCollectionViewCell", bundle: Bundle.main),
                                     forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
        self.pageControl.numberOfPages = self.pages.count
    }
    
    // MARK: - Outlet functions for the viewController
    @IBAction func pageChanged(_ sender: Any) {
        let pageControl = sender as! UIPageControl
        
        collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: 0),
                                    at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        PersistableService.shared.setIsOldUser()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - CollectionView dataSource & collectionView FlowLayout delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell",
                                                      for: indexPath) as! OnboardingCollectionViewCell
        cell.configureCell(page: pages[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    // MARK: - Function to update the UIPageControl
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
