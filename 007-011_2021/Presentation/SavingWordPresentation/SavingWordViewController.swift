//
//  SavingWordViewController.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 09.12.2021.
//

import UIKit

class SavingWordViewController: UIViewController {
    // Outlet properties
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var definitionLabel: UILabel!
    
    // public properties
    var word: Word?
    
    // private properties
    let dataStoreInteractor = DataStoreInteractor()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Button actions
    @IBAction func saveButtonAction(_ sender: Any) {
        guard let guardWord = word else { return }
    
        dataStoreInteractor.saveWord(word: guardWord)
        saveButton.isEnabled = false
    }
    
    // MARK: - Private functions
    private func configure() {
        guard let guardWord = word else { return }
        let guardMeanings = guardWord.meanings ?? []
        
        if !guardMeanings.isEmpty {
            let definitions = guardMeanings[0].definitions ?? []
            
            if !definitions.isEmpty {
                definitionLabel.text = definitions[0].definition
            } else {
                definitionLabel.text = "Can't find a definition!"
            }
        }
        
        if dataStoreInteractor.isContainsWord(word: guardWord) {
            saveButton.isEnabled = false
        }
    }
}
