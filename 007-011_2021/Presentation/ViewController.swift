//
//  ViewController.swift
//  007-011_2021
//
//  Created by ilyas.ikhsanov on 20.11.2021.
//

import UIKit


final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    let networkService: NetworkService = NetworkService()
    var words: [Word] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        configSearchBar()
        
        getWord()
      
    }
    
    private func getWord() {
        networkService.getWord { result in
            switch result {
            case .success(let words):
                self.words = words
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
 
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func configSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = words[indexPath.row].word
      
        return cell
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        print(searchText)
        
    }
}
