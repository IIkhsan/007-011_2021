//
//  PersistableViewController.swift
//  007-011_2021
//
//  Created by Evans Owamoyo on 13.12.2021.
//

import UIKit

class PersistableViewController: SearchController {
    
    let persistableService = PersistableService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        words = persistableService.fetchWords()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && persistableService.deleteWord(word: words![indexPath.row].word) {
            words!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }

}

// MARK: SearchControllerDelegate
extension PersistableViewController: SearchControllerDelegate {
    func searchText(with string: String?, completion: @escaping ([Word]) -> Void) {
        completion(persistableService.fetchWords(startsWith: string))
    }
}

extension PersistableViewController: NetworkDictionaryViewControllerDelegate {
    func persistenceUpdated() {
        print("called")
        words = persistableService.fetchWords()
        tableView.reloadData()
    }
}
