//
//  OnboardingViewController.swift
//  007-011_2021
//
//  Created by andrewoch on 09.12.2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - Properties
    let model = OnboardingModel()
    var currentPage = 0
    var isSkipped: Bool {
        return UserDefaults.standard.bool(forKey: OnboardingUDKeyValues.onboardingStatus.rawValue)
    }
    
    //MARK: - IBActions
    @IBAction func nextButtonPressed(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: OnboardingUDKeyValues.onboardingStatus.rawValue)
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    //MARK: - Private functions
    private func skipIfNeeded() {
        if isSkipped {
            performSegue(withIdentifier: "next", sender: nil)
        }
    }
    
    //MARK: - Lifecycle
    
    init(_ onboardingPageData: OnboardingPageData) {
        super.init(nibName: nil, bundle: nil)

        //titleLabel.text = onboardingPageData.title
        //functionalityImageView.image = onboardingPageData.image
        //descriptionLabel.text = onboardingPageData.description
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        if isSkipped {
            return
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        pageControl.numberOfPages = model.slides.count
    }

    override func viewDidAppear(_ animated: Bool) {
        skipIfNeeded()
    }
}

//MARK: - UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "slide", for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(slide: model.slides[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
}
