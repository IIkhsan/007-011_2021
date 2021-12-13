//
//  CustomSerchingTableViewCell.swift
//  007-011_2021
//
//  Created by Тимур Миргалиев on 26.11.2021.
//

import UIKit
import AVFoundation
class CustomSerchingTableViewCell: UITableViewCell {

    //MARK: - UI
    @IBOutlet weak var titleOfWord: UILabel!
    @IBOutlet weak var detailOfWord: UILabel!
    
    func configure(title: String, detail: String) {
        titleOfWord.text = title
        detailOfWord.text = detail
    }
}
