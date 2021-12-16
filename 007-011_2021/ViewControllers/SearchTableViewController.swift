//
//  SearchTableViewController.swift
//  007-011_2021
//
//  Created by Alexandr Onischenko on 14.12.2021.
//

import UIKit
import CoreData

class SearchTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    
    var words = [Word]()
    let searchController = UISearchController()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
    
        definesPresentationContext = true
        
        tableView.register(WordTableViewCell.self, forCellReuseIdentifier: "WordTableViewCell")
        tableView.alwaysBounceVertical = false
    }
    
    // MARK: - Configure UISearchController
    
    func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.setValue("Search", forKey: "cancelButtonText")
        searchController.searchBar.placeholder = "For example: apple"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchController.searchBar)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordTableViewCell", for: indexPath) as? WordTableViewCell else { return WordTableViewCell() }
        
        let word = words[indexPath.row]
        cell.configure(with: word)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeAdd = UIContextualAction(style: .normal, title: "Добавить") { action, view, success in
            
            let word = self.words[indexPath.row]
            WordInteractorService.shared.save(word: word)
            
            
            self.words.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            success(true)
        }
        
        swipeAdd.backgroundColor = #colorLiteral(red: 0.0647950992, green: 0.7697049975, blue: 0.2606219947, alpha: 1)
        return UISwipeActionsConfiguration(actions: [swipeAdd])
    }
}

// MARK: - Realization UISearchBarDelegate

extension SearchTableViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        if !text.isEmpty {
            NetworkService.shared.getWord(text) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let words):
                    self.words = words
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    self.words = [Word(word: "Word not found", phonetic: "Try again", phonetics: nil, origin: nil, meanings: nil)]
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    print("Error: \(error.localizedDescription)")
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
