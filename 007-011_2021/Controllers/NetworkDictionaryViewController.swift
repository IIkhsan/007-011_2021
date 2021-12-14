//
//  NetworkDictionaryViewController.swift
//  007-011_2021
//
//  Created by Evans Owamoyo on 13.12.2021.
//

import UIKit

protocol NetworkDictionaryViewControllerDelegate: AnyObject {
    // Function called whenever a new Word is added to the
    // persistence or db
    func persistenceUpdated()
}

class NetworkDictionaryViewController: SearchController {
    // MARK: properties
    private let networkService = NetworkService()
    private let persistableService = PersistableService.shared
    weak var networkDelegate: NetworkDictionaryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addToDbAction = UIContextualAction(style: .normal, title: "Add Favorite") { [weak self] action, view, completion in
            if let self = self {
                self.persistableService.addWord(word: self.words![indexPath.row])
                completion(true)
                self.networkDelegate?.persistenceUpdated()
                self.clearSearchBar()
            }
            completion(false)
        }
        addToDbAction.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [addToDbAction])
    }
    
}

extension NetworkDictionaryViewController: SearchControllerDelegate {
    func searchText(with string: String?, completion: @escaping ([Word]) -> Void) {
        if let string = string {
            if (string.isEmpty) { return }
            networkService.fetchWord(with: string) { result in
                switch result {
                    case .success(let words):
                        completion(words)
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
}
