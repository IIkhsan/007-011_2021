//
//  SearchingTableViewCell.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 01.12.2021.
//

import UIKit

class SearchingTableViewCell: UITableViewCell {
    // Outlet properties
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var transcriptionLabel: UILabel!
    
    // MARK: - Standart configure functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public functions
    func setWord(word: Word) {
        wordLabel.text = word.word
        let transcription = word.phonetics?[0].text
        
        if transcription == nil {
            transcriptionLabel.text = ""
        } else {
            transcriptionLabel.text = transcription
        }
    }
}
