//
//  PhoneticsTableView.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 12.12.2021.
//

import UIKit

class PhoneticsMeaninsTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellValueLabel: UILabel!
    
    // MARK: - Functions
    func config(title: String, value: String) {
        cellTitleLabel.text = title
        cellValueLabel.text = value
    }
}
