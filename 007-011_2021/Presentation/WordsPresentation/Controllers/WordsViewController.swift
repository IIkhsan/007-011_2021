//
//  WordsViewController.swift
//  007-011_2021
//
//  Created by ilyas.ikhsanov on 20.11.2021.
//

import UIKit


final class WordsViewController: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Dependencies
    var words: [Word] = Interactor.shared.fetchWords()
    
    // MARK: -  View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    // MARK: - Functions
    //Private functions
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    //override functions
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        tableView.setEditing(editing, animated: true)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension WordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordsTableViewCell") as? WordsTableViewCell else {
            return UITableViewCell()
        }
        cell.config(word: words[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cell = tableView.cellForRow(at: indexPath) as? WordsTableViewCell
            if let word = cell?.wordLabel.text {
                Interactor.shared.deleteWord(word)
            }
            words = Interactor.shared.fetchWords()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

//MARK: - UITabBarControllerDelegate
extension WordsViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        words = Interactor.shared.fetchWords()
        tableView.reloadData()
    }
}
