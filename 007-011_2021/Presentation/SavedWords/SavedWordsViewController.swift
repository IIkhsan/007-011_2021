//
//  SavedWordsViewController.swift
//  007-011_2021
//
//  Created by Семен Соколов on 24.11.2021.
//

import UIKit

class SavedWordsViewController: UIViewController {
    
    //MARK: - UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK: - Properties
    var data: [Word] = Interactor.persistableService.getAllWords()

    //MARK: - View controller's cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UserHelperService.shared.isNewUser() {
            let viewController = storyboard?.instantiateViewController(withIdentifier: "onboarding") as! OnboardingViewController
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
        }
    }
    
    //MARK: - Private function
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        searchTextField.delegate = self
    }
}

// MARK: - UITextFieldDelegate
extension SavedWordsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        Interactor.networkService.getWord(word: textField.text ?? "" ) { [weak self] result in
            switch result {
            case .success(let word):
                DispatchQueue.main.async {
                    self?.performSegue(withIdentifier: "search", sender: word[0])
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    textField.text = ""
                })
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search", let viewController = segue.destination as? SearchWordsViewController, let word = sender as? Word {
            viewController.word = word
            viewController.delegate = self
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
}

// MARK: - SearchWordsViewController
extension SavedWordsViewController: SearchWordsViewControllerDelegate {
    
    func saveNewWord(word: Word) {
        Interactor.persistableService.addWordToCoreData(word: word)
        data = Interactor.persistableService.getAllWords()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SavedWordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as? WordTableViewCell else { return UITableViewCell() }
        cell.setData(word: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        Interactor.persistableService.removeWordEntity(word: data[indexPath.row])
        data = Interactor.persistableService.getAllWords()
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}
