//
//  OnboardingModel.swift
//  007-011_2021
//
//  Created by andrewoch on 09.12.2021.
//

import Foundation
import UIKit

class OnboardingModel {
    
    //MARK: - Properties
    lazy var slides: [OnboardingSlide] = {
        var result: [OnboardingSlide] = []
        let storedImage = UIImage(named: "stored")!
        let searchImage = UIImage(named: "search")!
        result.append(OnboardingSlide(image: storedImage, mainText: "Store words in your phone!", description: "You can add words to your dictionary and learn language every day"))
        result.append(OnboardingSlide(image: searchImage, mainText: " Discover new words in web", description: "Search new words in internet"))
        return result
    }()
}
