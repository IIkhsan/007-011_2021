//
//  SavedWordTableViewCell.swift
//  007-011_2021
//
//  Created by Marat Giniyatov on 13.12.2021.
//

import UIKit

class SavedWordTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var phoneticLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - cell configuration method
    func configureCell(word: Word) {
        wordLabel.text = word.word
        phoneticLabel.text = word.phonetics[0].text
    }

}
