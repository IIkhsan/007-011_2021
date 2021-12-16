//
//  SavedWordsTableViewController.swift
//  007-011_2021
//
//  Created by Alexandr Onischenko on 14.12.2021.
//

import UIKit
import SnapKit

class SavedWordsTableViewController: UIViewController {
    
    // MARK: - Properties
    var words = [Word]()
    var searchButton = UIButton()
    var tableView = UITableView()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Saved words"
        navigationController?.navigationBar.isTranslucent = true
        
        configureTableView()
        configureSearchButton()
        configureDeleteBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        words = WordInteractorService.shared.getSavedWords()
        tableView.reloadData()
    }
    
    // MARK: - Private functions
    
    @objc private func searchButtonTapped() {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "SearchTableViewController") as? SearchTableViewController else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func deleteAllWords() {
        words.removeAll()
        WordInteractorService.shared.clear()
        tableView.reloadData()
    }
    
    // MARK: - Congigure view functions
    
    func configureSearchButton() {
        searchButton = UIButton(type: .system)
        searchButton.configuration = .filled()
        searchButton.configuration?.title  = "Search word"
        searchButton.configuration?.image = UIImage(systemName: "book.fill")
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.bottom.equalToSuperview().inset(40)
            $0.height.equalTo(60)
        }
    }
    
    func configureDeleteBarButton() {
        let barButtonItem = UIBarButtonItem(title: "Delete all", style: .done, target: self, action: #selector(deleteAllWords))
        barButtonItem.tintColor = .red
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func configureTableView() {
        tableView.alwaysBounceVertical = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WordTableViewCell.self, forCellReuseIdentifier: "WordTableViewCell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.right.left.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

// MARK: - Realization UITableViewDelegate

extension SavedWordsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
        
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeAdd = UIContextualAction(style: .destructive, title: "Удалить") { action, view, success in
            
            let word = self.words[indexPath.row]
            WordInteractorService.shared.delete(word: word)
            
            self.words.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            success(true)
        }
        
        return UISwipeActionsConfiguration(actions: [swipeAdd])
    }
}

// MARK: - Realization UITableViewDataSource
extension SavedWordsTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordTableViewCell", for: indexPath) as? WordTableViewCell else { return WordTableViewCell() }
        
        let word = words[indexPath.row]
        cell.configure(with: word)
        
        return cell
    }
}

