//
//  PhoneticsTableView.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 12.12.2021.
//

import UIKit

class PhoneticsTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var phoneticTextLabel: UILabel!
    
    // MARK: - Functions
    func config(phoneticText: String) {
            phoneticTextLabel.text = phoneticText
    }
}
