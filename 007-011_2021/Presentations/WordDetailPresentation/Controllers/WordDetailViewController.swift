//
//  WordDetailViewController.swift
//  007-011_2021
//
//  Created by Danil Gerasimov on 09.12.2021.
//

import UIKit


class WordDetailViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var detailsTableView: UITableView!
    
    //MARK: - VC properties
    var word: WordResponseModel?
    let persistableInteractor: PersistableServiceInteractor = PersistableServiceInteractor.shared
    
    //MARK: - VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.rowHeight = UITableView.automaticDimension
        detailsTableView.estimatedRowHeight = 600
    }
    //MARK: - IBActions
    @IBAction func saveButtonPressed(_ sender: Any) {
        if let word = self.word {
            persistableInteractor.saveWord(word)
        }
        navigationController?.popViewController(animated: true)
    }
}
//MARK: - UITableViewDelegate, DataSource extensions
extension WordDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = detailsTableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as? DetailTableViewCell else { return UITableViewCell() }
        switch indexPath.row {
        case 0:
            cell.configure(title: "Word", value: word?.word ?? "No info" )
        case 1:
            if !(word?.phonetics.isEmpty ?? false) {
                cell.configure(title: "Phonetic", value: word?.phonetics[0].text ?? "No info")
            } else {
                cell.configure(title: "Phonetic", value: "None")
            }
        case 2:
            cell.configure(title: "Part of speech", value: word?.meanings[0].partOfSpeech ?? "No info")
        case 3:
            cell.configure(title: "Definition", value: word?.meanings[0].definitions[0].definition ?? "No info" )
        case 4:
            cell.configure(title: "Example", value: word?.meanings[0].definitions[0].example ?? "No info")
        default:
            cell.configure(title: "Label", value: "Label")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
