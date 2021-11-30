//
//  SavedWordsViewController.swift
//  007-011_2021
//
//  Created by Роман Сницарюк on 20.11.2021.
//

import UIKit
import SnapKit

final class SavedWordsViewController: UIViewController {
  // MARK: - UI
  private lazy var savedWordsTableView: UITableView = {
    let tableView = UITableView()
    tableView.separatorStyle = .singleLine
    tableView.register(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.identifier)
    tableView.backgroundColor = .customColor
    return tableView
  }()
  
  // MARK: - Propetrties
  private var words: [Word] = []
  
  // Dependencies
  private let interactor: Interactor = InteractorImpl()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews()
    setConstraints()
    configure()
    words = interactor.readWords()
  }
  
  // MARK: - Private
  private func configure() {
    title = "Сохраненные слова"
    
    savedWordsTableView.delegate = self
    savedWordsTableView.dataSource = self
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
  }
  
  private func addSubviews() {
    view.addSubview(savedWordsTableView)
  }
  
  private func setConstraints() {
    savedWordsTableView.snp.makeConstraints { make in
      make.top.left.bottom.right.equalToSuperview().inset(0)
    }
  }
  
  private func deleteWord(indexPath indexpath: IndexPath) -> UIContextualAction {
    let action = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, _ in
      guard let self = self else { return }
      self.interactor.deleteWord(self.words[indexpath.row])
      self.words.remove(at: indexpath.row)
      self.savedWordsTableView.reloadData()
    }
    action.image = UIImage(named: "trash")
    return action
  }
  
  // objc
  @objc private func searchButtonTapped() {
    let searchViewController = SearchWordViewController()
    searchViewController.saveWordDelegate = self
    navigationController?.pushViewController(searchViewController, animated: true)
  }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension SavedWordsViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return words.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.identifier, for: indexPath) as? WordTableViewCell else { return UITableViewCell() }
    cell.configure(words[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let delete = deleteWord(indexPath: indexPath)
    let swipe = UISwipeActionsConfiguration(actions: [delete])
    return swipe
  }
}

// MARK: - SaveWordDelegate
extension SavedWordsViewController: SaveWordDelegate {
  func saveWord(_ word: Word) {
    interactor.saveWord(word)
    words.append(word)
    DispatchQueue.main.async {
      self.savedWordsTableView.reloadData()
    }
  }
}
