//
//  FavouritesViewController.swift
//  007-011_2021
//
//  Created by andrewoch on 09.12.2021.
//

import UIKit
import CoreLocation

class FavouritesViewController: UITableViewController {
    
    //MARK: - IBOutlets
    private let searchController = UISearchController()
    
    //MARK: - Properties
    let model = SavedWordsModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        setUpSearchBar()
        setUpDelegates()
        tableView.register(UINib(nibName: "WordTableViewCell", bundle: nil), forCellReuseIdentifier: "wordCell")
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.storedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell") as? WordTableViewCell else { return UITableViewCell() }
        cell.configure(word: model.filtered[indexPath.row])
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "DetailedViewController") as! DetailedViewController
        
        vc.word = model.storedWords[indexPath.row]
        vc.saved = true
        self.present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
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
        guard let searchWordsController = navigationController.viewControllers[0] as? SearchTableViewController else { return }
        searchWordsController.delegate = self
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchWords" {
            guard let navigationController  = segue.destination as? UINavigationController else { return }
            guard let searchWordsVC = navigationController.viewControllers[0] as? SearchTableViewController else { return }
            searchWordsVC.delegate = self
        }
    }
}

//MARK: - Search results updating
extension FavouritesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterWords()
    }
}

//MARK: - SearchWordsVCDelegate
extension FavouritesViewController: SearchVCDelegate {
    func wordDidSave() {
        model.updateWords()
        filterWords()
    }
}
