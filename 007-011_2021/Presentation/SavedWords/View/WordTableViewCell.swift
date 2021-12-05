//
//  WordTableViewCell.swift
//  007-011_2021
//
//  Created by Ильдар Арсламбеков on 02.12.2021.
//

import UIKit
import CloudKit

class WordTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var phoneticLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    //MARK: - Properties
    var wordCell: Word? = nil
    var action: ((Word) -> Void)? = nil
    
    //MARK: - IBActions
    @IBAction func addButtonPressed(_ sender: Any) {
        guard let word = wordCell, let action = action else {
            return
        }
        action(word)
    }
    
    //MARK: - Public functions
    func configure(word: Word, cellType: CellType) {
        wordCell = word
        phoneticLabel.text = word.phonetic
        wordLabel.text = word.word
        switch cellType {
        case .withAddButton:
            return
        case .withoutButton:
            addButton.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
