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
    var data: [Word] = persistableService.getAllWords()
    
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
        persistableService.removeWordEntity(word: data[indexPath.row])
        data = persistableService.getAllWords()
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}
