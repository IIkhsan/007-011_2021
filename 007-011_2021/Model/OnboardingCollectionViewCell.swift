//
//  OnboardingCollectionViewCell.swift
//  007-011_2021
//
//  Created by andrewoch on 09.12.2021.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: - Public functions
    public func configure(slide: OnboardingSlide) {
        imageView.image = slide.image
        imageView.clipsToBounds = true
        mainLabel.text = slide.mainText
        descriptionLabel.text = slide.description
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
