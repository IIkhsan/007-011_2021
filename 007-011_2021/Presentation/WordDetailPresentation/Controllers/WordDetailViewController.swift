//
//  WordDetailViewController.swift
//  007-011_2021
//
//  Created by Эльмира Байгулова on 12.12.2021.
//

import UIKit

class WordDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var secondTableView: UITableView!
    @IBOutlet weak var firstTableView: UITableView!
    @IBOutlet weak var wordLabel: UILabel!
    
    // MARK: - Dependencies
    var word: Word?
    let persistableService: PersistableService = PersistableService()

    override func viewDidLoad() {
        super.viewDidLoad()
        wordLabel.text = word?.word
        
        firstTableView.delegate = self
        firstTableView.dataSource = self
        firstTableView.rowHeight = UITableView.automaticDimension
        
        secondTableView.delegate = self
        secondTableView.dataSource = self
        secondTableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - @IBAction
    @IBAction func saveButtonPressed(_ sender: Any) {
        if let word = self.word {
            persistableService.saveWordEntity(word)
        }
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension WordDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == firstTableView {
            guard let phonetiCell = tableView.dequeueReusableCell(withIdentifier: "PhoneticsTableViewCell") as? PhoneticsTableViewCell else { return UITableViewCell() }
            if !(word?.phonetics.isEmpty ?? false) {
                phonetiCell.config(phoneticText: word?.phonetics[0].text ?? "No info")
            } else {
                phonetiCell.config( phoneticText: "None")
            }
            return phonetiCell
        } else {
            guard let meaningCell = tableView.dequeueReusableCell(withIdentifier: "MeaningsTableViewCell") as? MeaningsTableViewCell else { return UITableViewCell() }
            meaningCell.config(partOfSpeech: word?.meanings[0].partOfSpeech ?? "No value", definition: word?.meanings[0].definitions[0].definition ?? "No info", example: word?.meanings[0].definitions[0].example ?? "No info")
            return meaningCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

