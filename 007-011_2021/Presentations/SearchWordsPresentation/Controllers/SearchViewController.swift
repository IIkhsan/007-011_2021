//
//  SearchViewController.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 09.12.2021.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var wordsSearchBar: UISearchBar!
    @IBOutlet weak var wordsTableView: UITableView!
    
    //MARK: - VC properties
    var words: [WordResponseModel] = [WordResponseModel]()
    
    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        wordsSearchBar.delegate = self
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
    }
}

//MARK: - UISearchBarDelegate extension
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let networkInteractor = NetworkServiceInteractor.shared
        guard let word = wordsSearchBar.text else { return }
        networkInteractor.getWords(word: word) { [weak self] result in
            switch result {
            case .failure(let error):
                AlertPresenter.showAlert(message: error.localizedDescription, on: self)
            case .success(let words):
                self?.words = words
                DispatchQueue.main.async {
                    self?.wordsTableView.reloadData()
                }
                print("updated")
            }
        }
    }
}

//MARK: - UITableViewDelegate, DataSource extensions
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = wordsTableView.dequeueReusableCell(withIdentifier: "WordTableViewCell") as? WordTableViewCell else { return UITableViewCell() }
        cell.configure(word: words[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        wordsTableView.deselectRow(at: indexPath, animated: true)
        let cell = wordsTableView.cellForRow(at: indexPath) as? WordTableViewCell
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "WordDetailViewController") as? WordDetailViewController else { return }
        vc.word = cell?.word
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
