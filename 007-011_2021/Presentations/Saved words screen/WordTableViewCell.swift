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
    label.numberOfLines = 0
    label.font = label.font.withSize(22)
    label.sizeToFit()
    return label
  }()
  
  private lazy var phoneticTextLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.textAlignment = .left
    label.numberOfLines = 0
    label.font = label.font.withSize(22)
    label.sizeToFit()
    return label
  }()
  
  private lazy var contentStackView: UIStackView = {
    let stack = UIStackView()
    stack.spacing = 5
    stack.distribution = .fill
    stack.axis = .horizontal
    return stack
  }()
  
  // MARK: - Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = UIColor.customColor
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
    contentView.addSubview(contentStackView)
    contentStackView.addArrangedSubview(wordNameTextLabel)
    contentStackView.addArrangedSubview(phoneticTextLabel)
  }
  
  private func setConstraints() {
    contentStackView.snp.makeConstraints { make in
      make.top.bottom.equalToSuperview().inset(10)
      make.leading.trailing.equalToSuperview().inset(10)
    }
  }
}
