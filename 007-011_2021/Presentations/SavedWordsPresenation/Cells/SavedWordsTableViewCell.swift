//
//  SavedWordsTableViewCell.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 10.12.2021.
//

import UIKit

class SavedWordsTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var phoneticLabel: UILabel!
    
    //MARK: - Cell lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Cell methods
    func configure(word: WordResponseModel) {
        if !word.phonetics.isEmpty {
            phoneticLabel.text = word.phonetics[0].text
        } else {
            phoneticLabel.text = "None"
        }
        wordLabel.text = word.word
    }

}
