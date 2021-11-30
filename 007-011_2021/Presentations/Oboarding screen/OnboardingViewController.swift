//
//  OnboardingViewController.swift
//  007-011_2021
//
//  Created by Роман Сницарюк on 24.11.2021.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
  // MARK: - UI
  private lazy var mainImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    return view
  }()
  
  private lazy var titleTextLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .black
    label.font = label.font.withSize(24)
    label.textAlignment = .center
    label.sizeToFit()
    return label
  }()
  
  private lazy var descriptionTextLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .black
    label.font = label.font.withSize(20)
    label.textAlignment = .center
    label.sizeToFit()
    return label
  }()
  
  private lazy var mainStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 20
    stack.alignment = .center
    return stack
  }()
  
  // MARK: - Init
  init(image: UIImage?, titleText: String?, description: String?) {
    super.init(nibName: nil, bundle: nil)
    mainImageView.image = image
    titleTextLabel.text = titleText
    descriptionTextLabel.text = description
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    addSubviews()
    setConstraints()
  }
  
  // MARK: - Private
  private func configure() {
    view.backgroundColor = .customColor
  }
  
  private func addSubviews() {
    view.addSubview(mainStackView)
    mainStackView.addArrangedSubview(mainImageView)
    mainStackView.addArrangedSubview(titleTextLabel)
    mainStackView.addArrangedSubview(descriptionTextLabel)
  }
  
  private func setConstraints() {
    mainStackView.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.75)
      make.width.equalToSuperview().multipliedBy(0.9)
      make.centerX.centerY.equalTo(self.view)
    }
    mainImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
  }
}
