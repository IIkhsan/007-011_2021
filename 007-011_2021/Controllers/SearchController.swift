//
//  SearchController.swift
//  007-011_2021
//
//  Created by Evans Owamoyo on 12.12.2021.
//

import Foundation
import UIKit

// MARK: SearchControllerDelegate
protocol SearchControllerDelegate: AnyObject {
    func searchText(with string: String?, completion: @escaping ([Word]) -> Void)
}

class SearchController: UITableViewController {
    // MARK: properties
    private let searchController = UISearchController(searchResultsController: nil)
    weak var delegate: SearchControllerDelegate?
    var words: [Word]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSearchController()
    }
    
    private func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Dictionary"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func clearSearchBar() {
        searchController.searchBar.text = ""
    }
    
    //MARK: TableViewDataSources
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
        let word = words![indexPath.row].word
        let phonetic = words![indexPath.row].phonetic ?? ""
        cell.textLabel?.text = word
        cell.detailTextLabel?.text = phonetic
        return cell
    }
    
    
}

// MARK: UISearchResultsUpdating
extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        delegate?.searchText(with: searchController.searchBar.text)
        { [weak self] words in
            DispatchQueue.main.async {
                self?.words = words
                self?.tableView.reloadData()
            }
        }
    }
}
