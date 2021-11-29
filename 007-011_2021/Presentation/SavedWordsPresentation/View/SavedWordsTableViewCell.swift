//
//  MainTableViewCell.swift
//  007-011_2021
//
//  Created by Даниил Багаутдинов on 25.11.2021.
//

import UIKit

class SavedWordsTableViewCell: UITableViewCell {
    ///Outlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var phoneticLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Setting data for a sell
    /// - Parameter word: Word with data
    func setData(word: Word) {
        wordLabel.text = word.word
        phoneticLabel.text = word.phonetics[0].text
    }
}
