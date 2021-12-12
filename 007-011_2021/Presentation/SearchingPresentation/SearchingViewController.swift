//
//  SearchingViewController.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 24.11.2021.
//

import UIKit

class SearchingViewController: UIViewController {
    // Outlet properties
    @IBOutlet weak var searchingTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // private properties 
    private let networkService: NetworkService = NetworkService()
    private var searchingWords: [Word] = []
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Button actions
    @IBAction func findButtonAction(_ sender: Any) {
        guard let searchingText: String = searchingTextField.text else { return }
        
        networkService.getWord(word: searchingText, completion: { result in
            switch result {
            case .success(let words):
                self.searchingWords = words
            
            case .failure(let error):
                self.searchingWords = [Word(word: "No such word!", phonetics: nil, meanings: nil)]

                print(error)
            }
            
            DispatchQueue.main.async { [self] in
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier:  "SavedWordsViewController") as? SavedWordsViewController else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDeletage
extension SearchingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchingWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchingTableViewCell", for: indexPath) as? SearchingTableViewCell else { return UITableViewCell() }
        
        cell.setWord(word: searchingWords[indexPath.row])

        return cell as UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchingWords[0].word != "No such word!" {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "SavingWordViewController") as! SavingWordViewController
            vc.word = searchingWords[indexPath.row]
            navigationController?.present(vc, animated: true, completion: nil)
        }
    }
}
