//
//  SearchViewController.swift
//  007-011_2021
//
//  Created by Тимур Миргалиев on 24.11.2021.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK: - Properties
    var serchingWords: [Word] = []
    
    //MARK: - Private properties
    private let networkManager = NetworkManager()
    
    //MARK: - UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchingWord: UITextField!
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchingWord.delegate = self
    }
    
    //MARK: - Action Button
    @IBAction func didClickSearchButton(_ sender: Any) {
        let word: String = searchingWord.text ?? ""
        let someUrl = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)")
        networkManager.obtainWords(comletion: { result in
            switch result {
            case .success(let words):
                self.serchingWords = words
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
        return serchingWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! CustomSerchingTableViewCell
        let word = serchingWords[indexPath.row]
        cell.configure(title: word.word, detail: word.phonetic ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DeatilSearchingViewController") as? DetailSearchingViewController else {
            return
        }
        vc.word = serchingWords[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchingWord.resignFirstResponder()
        didClickSearchButton((Any).self)
        return true
    }
}
