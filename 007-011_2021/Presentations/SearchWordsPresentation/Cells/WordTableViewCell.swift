//
//  WordTableViewCell.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 09.12.2021.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var wordLabel: UILabel!
    
    //MARK: - Cell properties
    var word: WordResponseModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Cell methods
    /// Cell configuration
    /// - Parameter word: word with data
    func configure(word: WordResponseModel) {
        wordLabel.text = word.word
        self.word = word
    }
}
