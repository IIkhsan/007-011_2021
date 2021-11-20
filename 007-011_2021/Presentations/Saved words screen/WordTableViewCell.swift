//
//  WordTableViewCell.swift
//  007-011_2021
//
//  Created by Роман Сницарюк on 20.11.2021.
//

import UIKit

final class WordTableViewCell: UITableViewCell {
    
    static let identifier = "wordTableViewCell"
    
    // MARK: - UI
    private lazy var wordNameTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = label.font.withSize(18)
        label.sizeToFit()
        return label
    }()
    
    private lazy var phoneticTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = label.font.withSize(18)
        label.sizeToFit()
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(_ word: Word) {
        wordNameTextLabel.text = word.name
        if word.phonetic != nil {
            phoneticTextLabel.text = word.phonetic
        } else if word.phonetics.first != nil {
            phoneticTextLabel.text = word.phonetics.first!.text
        }
    }
    
    // MARK: - Private
    private func addSubviews() {
        contentView.addSubview(wordNameTextLabel)
        contentView.addSubview(phoneticTextLabel)
    }
    
    private func setConstraints() {
        wordNameTextLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(18)
        }
        phoneticTextLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.trailing.equalToSuperview().inset(18)
        }
    }
}
