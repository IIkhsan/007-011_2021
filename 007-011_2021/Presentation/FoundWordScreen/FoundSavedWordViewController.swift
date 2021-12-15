//
//  FoundSavedWordViewController.swift
//  007-011_2021
//
//  Created by Marat Giniyatov on 13.12.2021.
//

import UIKit
import AVFoundation


protocol FoundSavedWordViewControllerDelegate: AnyObject {
    func saveAndUpdate(word: Word)
}

class FoundSavedWordViewController: UIViewController {
    // MARK: - variables
    var word: Word?
    weak var delegate: FoundSavedWordViewControllerDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var phoneticLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!

    // MARK: - VC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = true
        checkWord()
        configureWord()
    }
    
    func checkWord(){
        guard let word = word else {return}
        if Interactor().persistableService.isExists(word: word) {
            saveButton.isEnabled = false
        }
    }
    // MARK: - word configuration method
    func configureWord() {
        wordLabel.text = word?.word
        phoneticLabel.text = word?.phonetics[0].text
        definitionLabel.text = word?.meanings[0].definitions[0].definition
        exampleLabel.text = word?.meanings[0].definitions[0].example
        originLabel.text = word?.origin
    }
    
    // MARK: - play sound method (redirects to browser)
    @IBAction func playerButtonAction(_ sender: Any) {
        let operationQueue = OperationQueue()
        operationQueue.addOperation {
            guard let audio = self.word?.phonetics.first?.audio else { return }
            let url = "https:\(audio)"
            print(url)
            UIApplication.shared.openURL(NSURL(string:url)! as URL)
    }
    }
    
    // MARK: - save word method
    @IBAction func saveButtonAction(_ sender: Any) {
        saveButton.isEnabled = false
        print("hehehee")
        guard let word = word else {return}
        delegate?.saveAndUpdate(word: word)
        
    }

}

