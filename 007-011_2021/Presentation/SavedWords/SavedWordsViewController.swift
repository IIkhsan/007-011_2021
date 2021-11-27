//
//  SavedWordsViewController.swift
//  007-011_2021
//
//  Created by Семен Соколов on 24.11.2021.
//

import UIKit

class SavedWordsViewController: UIViewController {
    
    //MARK: - Dependencies
    let networkService = NetworkService()
    
    //MARK: - View controller's cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getWord { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let word):
                print(word)
            }
        }
    }
    
}
