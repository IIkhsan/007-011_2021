//
//  SavedWordsTableViewCell.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 09.12.2021.
//

import UIKit

class SavedWordsTableViewCell: UITableViewCell {
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var transcriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
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
