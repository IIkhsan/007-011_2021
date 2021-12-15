//
//  WordDetailViewController.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 12.12.2021.
//

import UIKit

class WordDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var wordLabel: UILabel!
    
    // MARK: - Dependencies
    var word: Word?
    let interactor: Interactor = Interactor()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        wordLabel.text = word?.word
        
        firstTableView.delegate = self
        firstTableView.dataSource = self
        firstTableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - @IBAction
    @IBAction func saveButtonPressed(_ sender: Any) {
        if let word = self.word {
            interactor.saveWord(word)
        }
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension WordDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneticsMeaninsTableViewCell") as? PhoneticsMeaninsTableViewCell else { return UITableViewCell() }
        switch indexPath.row {

        case 0:
            if !(word?.phonetics.isEmpty ?? false) {
                cell.config(title: "Phonetic", value: word?.phonetics[0].text ?? "No info")
            } else {
                cell.config(title: "Phonetic", value: "None")
            }
        case 1:
            cell.config(title: "Part of speech", value: word?.meanings[0].partOfSpeech ?? "No info")
        case 2:
            cell.config(title: "Definition", value: word?.meanings[0].definitions[0].definition ?? "No info" )
        case 3:
            cell.config(title: "Example", value: word?.meanings[0].definitions[0].example ?? "No info")
        default:
            cell.config(title: "Label", value: "Label")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

