//
//  MeaningsTableView.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 12.12.2021.
//

import UIKit

class MeaningsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var partOfSpeechLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!

    // MARK: - Functions
    func config(partOfSpeech: String, definition: String, example: String) {
        partOfSpeechLabel.text = partOfSpeech
        definitionLabel.text = definition
        exampleLabel.text = example
    }
}
