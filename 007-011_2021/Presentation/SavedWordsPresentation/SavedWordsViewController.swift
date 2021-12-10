//
//  SavedWordsViewController.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 24.11.2021.
//

import UIKit

class SavedWordsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // properties
    private let dataStoreInteractor = DataStoreInteractor()
    private var savedWords: [Word] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        savedWords = dataStoreInteractor.getAllWords()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func searchingButtonAction(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier:  "SearchingViewController") as? SearchingViewController else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SavedWordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedWordsTableViewCell", for: indexPath) as? SavedWordsTableViewCell else { return UITableViewCell() }
        
        cell.setWord(word: savedWords[indexPath.row])

        return cell as UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            dataStoreInteractor.deleteWord(word: savedWords[indexPath.row])
            savedWords = dataStoreInteractor.getAllWords()
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
