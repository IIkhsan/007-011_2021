//
//  SearchViewController.swift
//  007-011_2021
//
//  Created by Тимур Миргалиев on 24.11.2021.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK: - Properties
    var searchingWords: [Word] = []
    
    //MARK: - Private properties
    private let networkManager = NetworkManager()
    
    //MARK: - UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wordTextField: UITextField!
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        wordTextField.delegate = self
    }
    
    //MARK: - Action Button
    @IBAction func didClickSearchButton(_ sender: Any) {
        let word: String = wordTextField.text ?? ""
        let someUrl = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)")
        networkManager.obtainWords(comletion: { result in
            switch result {
            case .success(let words):
                self.searchingWords = words
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }, generalUrl: (someUrl!))
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchingWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
        let word = searchingWords[indexPath.row]
        cell.textLabel?.text = word.word
        cell.detailTextLabel?.text = word.phonetic
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DeatilSearchingViewController") as? DetailSearchingViewController else {
            return
        }
        vc.word = searchingWords[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        wordTextField.resignFirstResponder()
        didClickSearchButton((Any).self)
        return true
    }
}
