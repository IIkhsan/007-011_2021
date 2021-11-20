//
//  SavedWordsViewController.swift
//  007-011_2021
//
//  Created by Роман Сницарюк on 20.11.2021.
//

import UIKit
import SnapKit

final class SavedWordsViewController: UIViewController {
    // MARK: - UI
    private lazy var savedWordsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.register(WordTableViewCell.self, forCellReuseIdentifier: WordTableViewCell.identifier)
        tableView.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        return tableView
    }()
    
    // MARK: - Propetrties
    private var words: [Word] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        configure()
        let word = Word(name: "test", phonetic: "test", phonetics: [], meanings: [])
        words.append(word)
    }
    
    // MARK: - Private
    private func configure() {
        savedWordsTableView.delegate = self
        savedWordsTableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
    }
    
    private func addSubviews() {
        view.addSubview(savedWordsTableView)
    }
    
    private func setConstraints() {
        savedWordsTableView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview().inset(0)
        }
    }
    
    // objc
    @objc private func searchButtonTapped() {
        print(1)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension SavedWordsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.identifier, for: indexPath) as? WordTableViewCell else { return UITableViewCell() }
        cell.configure(words[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
