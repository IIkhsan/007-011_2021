//
//  SearchingViewController.swift
//  007-011_2021
//
//  Created by Даниил Багаутдинов on 27.11.2021.
//

import UIKit
import AVFoundation

protocol SearchingViewControllerDelegate: AnyObject {
    func saveNewWord(word: Word)
}

class SearchingViewController: UIViewController {
    ///Dependency
    var word: Word?
    weak var delegate: SearchingViewControllerDelegate?
    var player: AVPlayer?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // MARK: - Button
    
    @IBAction func saveButton(_ sender: Any) {
        guard let word = word else { return }
        guard let searchingView = view as? SearchingView else { return }
        delegate?.saveNewWord(word: word)
        searchingView.saveButton.isEnabled = false
    }
    
    @IBAction func audioButton(_ sender: Any) {
        let operationQueue = OperationQueue()
        operationQueue.addOperation { [weak self] in
            guard let audio = self?.word?.phonetics[0].audio else { return }
            guard let url = URL(string: "https:\(audio)") else { return }
            try? AVAudioSession.sharedInstance().setCategory(.multiRoute)
            self?.player = AVPlayer(url: URL.init(string: "\(url)")!)
            self?.player?.play()
        }
    }
    
    // MARK: - Private function
    
    private func configure() {
        guard let word = word else { return }
        guard let searchingView = view as? SearchingView else { return }
        if (persistableService.isTrue(word: word)) {
            searchingView.saveButton.isEnabled = false
        } else {
            searchingView.saveButton.isEnabled = true
        }
        searchingView.wordLabel.text = word.word
        searchingView.phoneticLabel.text = word.phonetics[0].text
        searchingView.partOfSpeechLabel.text = word.meanings[0].partOfSpeech
        searchingView.definitionLabel.text = word.meanings[0].definitions[0].definition
        searchingView.exampleLabel.text = word.meanings[0].definitions[0].example
        
        searchingView.wordLabel.sizeToFit()
        searchingView.phoneticLabel.sizeToFit()
        searchingView.partOfSpeechLabel.sizeToFit()
        searchingView.definitionLabel.sizeToFit()
        searchingView.exampleLabel.sizeToFit()
    }
}
