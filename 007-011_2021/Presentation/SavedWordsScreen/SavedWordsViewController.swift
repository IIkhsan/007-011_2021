//
//  SavedWordsViewController.swift
//  007-011_2021
//
//  Created by Marat Giniyatov on 13.12.2021.
//

import UIKit

class SavedWordsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - variable
     var savedWords: [Word] = Interactor().persistableService.getSavedWords()

    // MARK: - VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - tableView configuration method
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if case let controller as FoundSavedWordViewController = segue.destination, segue.identifier == "foundWordSegue", let word = sender as? Word {
            controller.word = word
            controller.delegate = self
        }
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Попробовать еще раз", style: .default, handler: {_ in alertController.dismiss(animated: true, completion: nil)})
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }

    // MARK: - save button action
    @IBAction func searchButtonAction(_ sender: Any) {
        Interactor().networkService.getWord(word: searchTextField.text ?? "", completion: {[weak self] result in
            switch result {
            case .success(let word):
                DispatchQueue.main.async {
                    self?.performSegue(withIdentifier: "foundWordSegue", sender: word[0])
                }
            case .failure(let error):

                self?.showAlert(message: error.localizedDescription)
            }
       
            
        })
        
    }
    
}

// MARK: - table view extension
extension SavedWordsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedWordCell", for: indexPath) as? SavedWordTableViewCell else { return UITableViewCell()}
        cell.configureCell(word: savedWords[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedWords.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {_,_,_ in
            Interactor().persistableService.deleteSavedWord(word: self.savedWords[indexPath.row])
            self.savedWords = Interactor().persistableService.getSavedWords()

                tableView.deleteRows(at: [indexPath], with: .automatic)

            }
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])

                   configuration.performsFirstActionWithFullSwipe = true

                   return configuration
        }
    }
// MARK: - delegate
extension SavedWordsViewController: FoundSavedWordViewControllerDelegate {
    func saveAndUpdate(word: Word) {
        Interactor().persistableService.saveNewWord(word: word)
        savedWords = Interactor().persistableService.getSavedWords()
        self.tableView.reloadData()
    }
}
