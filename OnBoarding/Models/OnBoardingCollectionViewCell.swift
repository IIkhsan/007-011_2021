//
//  OnBoardingCollectionViewCell.swift
//  007-011_2021
//
//  Created by andrewoch on 19.12.2021.
//

import UIKit

// Custom UICollectionViewCell
class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var animationContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    static let identifier = "OnboardingCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // function to configure the cell
    func configureCell(page: Page){
        
        // set the title and description of the screen
        self.titleLabel.text = page.title
        self.descriptionTextView.text = page.description
    }
}
