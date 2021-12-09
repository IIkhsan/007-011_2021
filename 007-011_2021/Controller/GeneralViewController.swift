//
//  GeneralViewController.swift
//  007-011_2021
//
//  Created by Тимур Миргалиев on 20.11.2021.
//

import UIKit

class GeneralViewController: UIViewController {
    
    private var arrayOfWords: [Word] = []
    
    private let dataStoreManager = DataStoreManager()
    private let networkManager = NetworkManager()
    
    //MARK: - UI
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Life ......
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrayOfWords = dataStoreManager.getAllWords()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension GeneralViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "GeneralCell", for: indexPath)
        let word = arrayOfWords[indexPath.row]
        cell.textLabel?.text = word.word
        cell.detailTextLabel?.text = word.phonetic
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataStoreManager.removeWord(word: arrayOfWords[indexPath.row])
        arrayOfWords = dataStoreManager.getAllWords()
        tableView.deleteRows(at: [indexPath], with: .right)
    }
    
}
