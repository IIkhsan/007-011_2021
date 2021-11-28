//
//  ViewController.swift
//  007-011_2021
//
//  Created by ilyas.ikhsanov on 20.11.2021.
//

import UIKit

class SavedWordsViewController: UIViewController {
    var network = NetworkService()
    var words: [Word] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure()
        network.getWord { result in
            switch result {
                case .success(let word):
                    print(word)
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func configure() {
        guard let savedWordsView = view as? SavedWordsView else { return }
        savedWordsView.tableView.delegate = self
        savedWordsView.tableView.dataSource = self
        savedWordsView.searchTextField.delegate = self
    }
}

extension SavedWordsViewController: UITextFieldDelegate, UISearchBarDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        performSegue(withIdentifier: "searchingSegue", sender: textField.text)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchingSegue", let viewController = segue.destination as? SearchingViewController, let request = sender as? String {
            viewController.request = request
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let savedWordsView = view as? SavedWordsView else { return false }

        savedWordsView.searchTextField.resignFirstResponder()

        return true
    }
}

extension SavedWordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedWordsTableViewCell", for: indexPath) as? SavedWordsTableViewCell else { return UITableViewCell()}
        cell.setData(word: words[indexPath.row])
        return cell
    }
    
    
}

