//
//  DetailTableViewCell.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 09.12.2021.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    //MARK: - IBOutlet
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellValueLabel: UILabel!
    
    //MARK: - Cell lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Cell methods
    /// Cell outlets and etc. configuration
    /// - Parameters:
    ///   - title: title for cellTitleLabel
    ///   - value: value for cellValueLabel
    func configure(title: String, value: String) {
        cellTitleLabel.text = title
        cellValueLabel.text = value
    }
}
