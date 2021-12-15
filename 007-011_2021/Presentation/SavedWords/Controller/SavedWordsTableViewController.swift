//
//  SavedWordsTableViewController.swift
//  007-011_2021
//
//  Created by Ильдар Арсламбеков on 21.11.2021.
//

import UIKit
import CoreLocation

class SavedWordsTableViewController: UITableViewController {
    
    //MARK: - Properties
    lazy var searchController = {
        return UISearchController()
    }()
    let model = SavedWordsModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        setUpSearchBar()
        setUpDelegates()
        tableView.register(UINib(nibName: "WordTableViewCell", bundle: nil), forCellReuseIdentifier: "wordCell")
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.filtered.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell") as? WordTableViewCell else { return UITableViewCell() }
        cell.configure(word: model.filtered[indexPath.row], cellType: .withoutButton)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        model.deleteWord(word: model.filtered[indexPath.row])
        model.updateWords()
        filterWords()
        tableView.reloadData()
    }
    
    //MARK: - Private functions
    private func filterWords() {
        guard let text = searchController.searchBar.text else { return }
        if text == "" {
            model.filtered = model.storedWords
            tableView.reloadData()
            return
        }
        model.filtered = model.storedWords.filter({ word in
            if word.word.lowercased().contains(text.lowercased()) {
                return true
            }
            return false
        })
        tableView.reloadData()
    }
    
    private func setUpSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    private func setUpDelegates() {
        guard let navigationController = tabBarController?.viewControllers![1] as? UINavigationController else { return }
        guard let searchWordsController = navigationController.viewControllers[0] as? SearchWordsTableViewController else { return }
        searchWordsController.delegate = self
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchWords" {
            guard let navigationController  = segue.destination as? UINavigationController else { return }
            guard let searchWordsVC = navigationController.viewControllers[0] as? SearchWordsTableViewController else { return }
            searchWordsVC.delegate = self
        }
    }
}

//MARK: - Search results updating
extension SavedWordsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
       filterWords()
    }
}

//MARK: - SearchWordsVCDelegate
extension SavedWordsTableViewController: SearchWordVCDelegate {
    func wordDidSave() {
        model.updateWords()
        filterWords()
    }
}
