//
//  FindWordViewController.swift
//  007-011_2021
//
//  Created by Роман Сницарюк on 20.11.2021.
//

import UIKit

final class SearchWordViewController: UIViewController {
  // MARK: - UI
  private lazy var findWordsTableView: UITableView = {
    let tableView = UITableView()
    tableView.separatorStyle = .singleLine
    tableView.register(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.identifier)
    tableView.backgroundColor = .customColor
    return tableView
  }()
  
  private let searchController: UISearchController = {
    let searchController = UISearchController()
    searchController.searchBar.placeholder = "Найти слово"
    searchController.searchBar.layer.cornerRadius = 20
    return searchController
  }()
  
  // MARK: - Propetrties
  private var words: [Word] = []
  
  // Dependencies
  weak var saveWordDelegate: SaveWordDelegate?
  private let interactor: Interactor = InteractorImpl()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews()
    setConstraints()
    configure()
  }
  
  // MARK: - Private
  private func configure() {
    findWordsTableView.delegate = self
    findWordsTableView.dataSource = self
  
    searchController.searchBar.delegate = self
    
    title = "Поиск слов"
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
  }
  
  private func addSubviews() {
    view.addSubview(findWordsTableView)
  }
  
  private func setConstraints() {
    findWordsTableView.snp.makeConstraints { make in
      make.top.left.bottom.right.equalToSuperview().inset(0)
    }
  }
  
  private func saveWord(indexPath: IndexPath) -> UIContextualAction {
    guard let saveWordDelegate = saveWordDelegate else { return UIContextualAction() }
    let action = UIContextualAction(style: .normal, title: "Save") { _, _, completion in
      saveWordDelegate.saveWord(self.words[indexPath.row])
      completion(true)
    }
    action.backgroundColor = .systemGreen
    return action
  }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension SearchWordViewController: UITableViewDataSource, UITableViewDelegate {
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
    let save = saveWord(indexPath: indexPath)
    let swipe = UISwipeActionsConfiguration(actions: [save])
    return swipe
  }
}

// MARK: - UISearchResultsUpdating
extension SearchWordViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let text = searchBar.text, !text.isEmpty else { return }
    interactor.getWords(text) { result in
      switch result {
      case .failure(let error):
        DispatchQueue.main.async {
          self.showAlert(title: "Error", message: error.localizedDescription)
        }
      case .success(let words):
        self.words = words
        DispatchQueue.main.async {
          self.findWordsTableView.reloadData()
        }
      }
    }
    searchBar.resignFirstResponder()
  }
}
