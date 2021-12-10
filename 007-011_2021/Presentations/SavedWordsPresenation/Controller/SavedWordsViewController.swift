//
//  SavedWordsViewController.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 07.12.2021.
//

import UIKit

class SavedWordsViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var wordsTableView: UITableView!
    
    //MARK: - VC properties
    var savedWords: [WordResponseModel] = PersistableServiceInteractor.shared.fetchWords()
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
        self.tabBarController?.delegate = self
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        wordsTableView.setEditing(editing, animated: true)
    }
    
}
//MARK: - UITableViewDelegate, UITableViewDataSource extensions
extension SavedWordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedWords.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = wordsTableView.dequeueReusableCell(withIdentifier: "SavedWordsTableViewCell") as? SavedWordsTableViewCell else { return UITableViewCell() }
        cell.configure(word: savedWords[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cell = wordsTableView.cellForRow(at: indexPath) as? SavedWordsTableViewCell
            if let word = cell?.wordLabel.text {
                PersistableServiceInteractor.shared.removeWord(word)
            }
            savedWords = PersistableServiceInteractor.shared.fetchWords()
            wordsTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

//MARK: - UITabBarControllerDelegate
extension SavedWordsViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        savedWords = PersistableServiceInteractor.shared.fetchWords()
        wordsTableView.reloadData()
    }
}


