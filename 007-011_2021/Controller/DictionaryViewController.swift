//
//  DictionaryViewController.swift
//  007-011_2021
//
//  Created by Илья Желтиков on 16.12.2021.
//

import UIKit

class DictionaryViewController: UIViewController {

    //MARK: - Properties
    private var arrayOfWords: [Word] = []
    private let dataStoreManager = DataStoreManager()
    private let networkManager = NetworkManager()
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.value(forKey: "Onboarding") == nil {
            let vc = storyboard?.instantiateViewController(withIdentifier: "StartScreen") as? StartScreenViewController
            vc?.modalPresentationStyle = .fullScreen
            present(vc ?? UIViewController(), animated: false)
        } else {
            super.viewWillAppear(animated)
            arrayOfWords = dataStoreManager.getAllWords()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
    //MARK: - UITableViewDataSource, UITableViewDelegate
    extension DictionaryViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrayOfWords.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DictionaryViwCell", for: indexPath)
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
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
                return
            }
            vc.word = arrayOfWords[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
