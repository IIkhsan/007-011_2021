//
//  ViewController.swift
//  007-011_2021
//
//  Created by ilyas.ikhsanov on 20.11.2021.
//

import UIKit

// MARK: - Protocol

protocol ChangeNameDelegate: AnyObject {
    func getWord(word: WordEntity)
}

class MainListViewController: UIViewController {
    
    // MARK: - UI Outlets
    
    @IBOutlet weak var favoriteWordTableView: UITableView!
    @IBOutlet weak var wordSearchBar: UISearchBar!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteWordTableView.delegate = self
        favoriteWordTableView.dataSource = self
        wordSearchBar.delegate = self
    }
    
    
}

// MARK: - TableView Delegate

extension MainListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
}

// MARK: - SearchBar Delegate

extension MainListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = wordSearchBar.text else { return }
        let _: () = NetworkService.shared.getData(word: searchText, completion: {[weak self] result in
            switch result {
            case .success(let word):
                DispatchQueue.main.async {
                    guard let detailVC = self?.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
                    detailVC.word = word
                    self?.present(detailVC, animated: true)
                }
                
                print(word)
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert: UIAlertController
                    switch error {
                    case .inputError:
                        alert = UIAlertController(title: "Ошибка ввода", message: "Поддерживаются только латинские символы", preferredStyle: .alert)
                        
                    case .processingError:
                        alert = UIAlertController(title: "Внутренняя ошибка", message: "Слово не может быть обработано", preferredStyle: .alert)
                        
                    case .noDataAvailable:
                        alert = UIAlertController(title: "Ошибка", message: "Слово не найдено", preferredStyle: .alert)
                        
                    case .serverUnavailable:
                        alert = UIAlertController(title: "Ошибка", message: "Сервер недоступен, попробуйте позже", preferredStyle: .alert)
                        
                    }
                    alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: .none))
                    self?.present(alert, animated: true)
                }
            }
        })
    }
}
