//
//  WelcomeCollectionViewCell.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 24.11.2021.
//

import UIKit

class WelcomeCollectionViewCell: UICollectionViewCell {
    
    //Properties
    static let identifier = String(describing: WelcomeCollectionViewCell.self)
    
    // MARK: - IBOutlets
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
    //MARK: - Functions
    func config(_ slide: WelcomeSlide) {
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
}
