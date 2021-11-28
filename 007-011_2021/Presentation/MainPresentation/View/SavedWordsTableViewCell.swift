//
//  MainTableViewCell.swift
//  007-011_2021
//
//  Created by Даниил Багаутдинов on 25.11.2021.
//

import UIKit

class SavedWordsTableViewCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(word: Word) {
        wordLabel.text = word.word
    }
}
