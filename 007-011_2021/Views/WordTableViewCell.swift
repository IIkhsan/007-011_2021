//
//  WordTableViewCell.swift
//  007-011_2021
//
//  Created by Alexandr Onischenko on 14.12.2021.
//

import UIKit
import SnapKit

class WordTableViewCell: UITableViewCell {
    
    var wordLabel: UILabel!
    var transcriptionLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        wordLabel = UILabel(frame: .zero)
        self.contentView.addSubview(wordLabel)
        wordLabel.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview().inset(20)
        }
        
        transcriptionLabel = UILabel(frame: .zero)
        transcriptionLabel.textColor = .gray
        self.contentView.addSubview(transcriptionLabel)
        transcriptionLabel.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with word: Word) {
        wordLabel.text = word.word
        transcriptionLabel.text = word.phonetic
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
