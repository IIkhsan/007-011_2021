//
//  WordTableViewCell.swift
//  007-011_2021
//
//  Created by Семен Соколов on 28.11.2021.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    
    //MARK: - UI
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var phoneticLabel: UILabel!
    
    //MARK: - Cell's methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Set word method
    func setData(word: Word) {
        wordLabel.text = word.word
        phoneticLabel.text = word.phonetics.first?.text
    }
}


