//
//  SearchViewController.swift
//  007-011_2021
//
//  Created by andrewoch on 08.12.2021.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    let model = SearchWordsModel()
    let searchController = UISearchController()
    var delegate: SearchVCDelegate? = nil
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        if !PersistableService.shared.isOldUser() {
            let onboardingStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let viewController = onboardingStoryboard.instantiateViewController(withIdentifier: "OnboardingViewController")
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
        }
        setUpSearchController()
        tableView.register(UINib(nibName: "WordTableViewCell", bundle: nil), forCellReuseIdentifier: "wordCell")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.words?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell") as? WordTableViewCell else { return UITableViewCell() }
        if model.words != nil {
            cell.configure(word: model.words![indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "DetailedViewController") as! DetailedViewController
        if model.words != nil {
            vc.word = model.words![indexPath.row]
            vc.saved = false
            vc.wordSaveAction = { [weak self] word in
                self?.model.saveWord(word: word)
                self?.delegate?.wordDidSave()
            }
        }
        
        self.present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Private functions
    private func setUpSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        if text == "" {
            model.words = nil
            tableView.reloadData()
        }
        model.fetchWords(word: text, completion: { [weak self] in
            self?.tableView.reloadData()
        })
    }
}
