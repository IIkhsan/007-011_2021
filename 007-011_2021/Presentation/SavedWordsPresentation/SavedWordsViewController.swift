//
//  ViewController.swift
//  007-011_2021
//
//  Created by ilyas.ikhsanov on 20.11.2021.
//

import UIKit

class SavedWordsViewController: UIViewController {
    /// Dependency
    var network = NetworkService()
    
    ///Property
    var words: [Word] = persistableService.getAllWords()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showOnboarding()
    }
    
    // MARK: - Private function
    /// Configuring view controller
    private func configure() {
        guard let savedWordsView = view as? SavedWordsView else { return }
        savedWordsView.tableView.delegate = self
        savedWordsView.tableView.dataSource = self
        savedWordsView.searchTextField.delegate = self
    }
    
    /// Сondition to show onboarding
    private func showOnboarding() {
        if UserDefaults.standard.value(forKey: "onboarding") == nil{
            let viewController = storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController
            viewController?.modalPresentationStyle = .fullScreen
            present(viewController ?? UIViewController(), animated: false)
        }
    }
}

// MARK: - UITextFieldDelegate

extension SavedWordsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        networkService.getWord(request: textField.text ?? "" ) { [weak self] result in
            switch result {
            case .success(let word):
                DispatchQueue.main.async {
                    self?.performSegue(withIdentifier: "searchingSegue", sender: word[0])
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
        if segue.identifier == "searchingSegue", let viewController = segue.destination as? SearchingViewController, let word = sender as? Word {
            viewController.word = word
            viewController.delegate = self
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let savedWordsView = view as? SavedWordsView else { return false }
        savedWordsView.searchTextField.resignFirstResponder()
        return true
    }
}

// MARK: - SearchingViewControllerDelegate

extension SavedWordsViewController: SearchingViewControllerDelegate {
    
    func saveNewWord(word: Word) {
        guard let savedWordsView = view as? SavedWordsView else { return }
        persistableService.addWordEntity(word: word)
        words = persistableService.getAllWords()
        savedWordsView.tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SavedWordsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedWordsTableViewCell", for: indexPath) as? SavedWordsTableViewCell else { return UITableViewCell()}
        cell.setData(word: words[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        persistableService.removeWordEntity(word: words[indexPath.row])
        words = persistableService.getAllWords()
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}
