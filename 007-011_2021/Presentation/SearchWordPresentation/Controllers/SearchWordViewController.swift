//
//  SearchWordViewController.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 13.12.2021.
//

import UIKit

class SearchWordViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var wordSearchBar: UISearchBar!
    @IBOutlet weak var wordsTableView: UITableView!
    
    //MARK: - Dependencies
    var words: [Word] = [Word]()
    
    // MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordSearchBar.delegate = self
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
    }
}

//MARK: - UISearchBarDelegate
extension SearchWordViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let interactor = Interactor.shared
        guard let word = wordSearchBar.text else { return }
        interactor.getWords(request: word) { [weak self] result in
            switch result {
            case .success(let words):
                self?.words = words
                DispatchQueue.main.async {
                    self?.wordsTableView.reloadData()
                }
                print("updated")
                print(words)
            case .failure(_):
                print("some error")
            }
        }
    }
}

//MARK: - UITableViewDelegate, DataSource
extension SearchWordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = wordsTableView.dequeueReusableCell(withIdentifier: "SearchWordTableViewCell") as? SearchWordTableViewCell else { return UITableViewCell() }
        cell.config(word: words[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        wordsTableView.deselectRow(at: indexPath, animated: true)
        let cell = wordsTableView.cellForRow(at: indexPath) as? SearchWordTableViewCell
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "WordDetailViewController") as? WordDetailViewController else { return }
        vc.word = cell?.word
        navigationController?.pushViewController(vc, animated: true)
    }
}

