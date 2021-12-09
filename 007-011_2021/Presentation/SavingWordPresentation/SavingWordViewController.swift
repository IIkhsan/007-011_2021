//
//  SavingWordViewController.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 09.12.2021.
//

import UIKit

class SavingWordViewController: UIViewController {
    @IBOutlet weak var saveButton: UIButton!
    
    // public properties
    var word: Word?
    
    // private properties
    let dataStoreInteractor = DataStoreInteractor()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        guard let guardWord = word else { return }
    
        dataStoreInteractor.saveWord(word: guardWord)
        saveButton.isEnabled = false
    }
    
    private func configure() {
        guard let guardWord = word else { return }
        
        if dataStoreInteractor.isContainsWord(word: guardWord) {
            saveButton.isEnabled = false
        }
    }
}
