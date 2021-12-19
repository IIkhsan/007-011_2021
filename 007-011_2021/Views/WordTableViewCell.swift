//
//  WordTableViewCell.swift
//  007-011_2021
//
//  Created by andrewoch on 09.12.2021.
//

import UIKit
import CloudKit

class WordTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var phoneticLabel: UILabel!
    
    //MARK: - Properties
    var wordCell: Word? = nil
    
    //MARK: - Public functions
    func configure(word: Word) {
        wordCell = word
        phoneticLabel.text = word.phonetic
        wordLabel.text = word.word
    }
}
