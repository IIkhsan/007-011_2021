//
//  SearchWordsViewController.swift
//  007-011_2021
//
//  Created by Семен Соколов on 26.11.2021.
//

import UIKit

protocol SearchWordsViewControllerDelegate: AnyObject {
    func saveNewWord(word: Word)
}

class SearchWordsViewController: UIViewController {
    
    //MARK: - UI
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var phoneticLabel: UILabel!
    @IBOutlet weak var partOfSpeechLabel: UILabel!
    @IBOutlet weak var defenitionLabel: UILabel!
    
    //MARK: - Properties
    var word: Word?
    weak var delegate: SearchWordsViewControllerDelegate?
    
    //MARK: - View controller's cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Button function
    @IBAction func saveButton(_ sender: Any) {
        guard let word = word else { return }
        delegate?.saveNewWord(word: word)
        dismiss(animated: true)
    }
    
    // MARK: - Private function
    private func configure() {
        guard let word = word else { return }
        wordLabel.text = word.word
        phoneticLabel.text = word.phonetics[0].text
        partOfSpeechLabel.text = word.meanings[0].partOfSpeech
        defenitionLabel.text = word.meanings[0].definitions[0].definition
    }
}
