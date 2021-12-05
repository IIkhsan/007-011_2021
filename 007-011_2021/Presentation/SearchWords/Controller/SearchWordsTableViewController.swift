//
//  SearchWordsTableViewController.swift
//  007-011_2021
//
//  Created by Ильдар Арсламбеков on 04.12.2021.
//

import UIKit

class SearchWordsTableViewController: UITableViewController {
    
    //MARK: - Properties
    let model = SearchWordsModel()
    let searchController = UISearchController()
    var delegate: SearchWordVCDelegate? = nil
    
    override func viewDidLoad() {
        setUpSearchController()
        tableView.register(UINib(nibName: "WordTableViewCell", bundle: nil), forCellReuseIdentifier: "wordCell")
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model.word == nil {
            return 0
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell") as? WordTableViewCell else { return UITableViewCell() }
        if model.word != nil {
            cell.configure(word: model.word!, cellType: .withAddButton)
            cell.action = { [weak self] word in
                self?.model.saveWord(word: word)
                self?.delegate?.wordDidSave()
            }
            return cell
        }
        return UITableViewCell()
    }
    
    //MARK: - Private functions
    private func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
}

extension SearchWordsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        if text == "" {
            model.word = nil
            tableView.reloadData()
        }
        model.fetchWord(word: text, completion: { [weak self] in
            self?.tableView.reloadData()
        })
    }
}
