//
//  DetailViewController.swift
//  007-011_2021
//
//  Created by Рустем on 18.12.2021.
//

import UIKit

// MARK: - Protocol

protocol GetWordDelegate: AnyObject {
    func onDataChange(word: WordEntity)
}

class DetailViewController: UIViewController {
    
    // MARK: - UI Outlets

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var originTextView: UITextView!
    @IBOutlet weak var pronounciationTextView: UITextView!
    @IBOutlet weak var audioPronounciationLink: UITextView!
    @IBOutlet weak var meaningsAndDataTextView: UITextView!
    @IBOutlet weak var addToFavoritesButton: UIButton!
    
    // MARK: - Properties

    var word: Word?
    weak var getWordDelegate: GetWordDelegate?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure(word: word)
    }
    
    // MARK: - Functions
    
    func configure(word: Word?) {
        guard let word = word else { return }
        wordLabel.text = word.word
        if word.origin != nil {
            originTextView.text = word.origin?.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
        } else {
            originTextView.text = "Происхождение неизвестно"
        }
        
        if word.phonetics != nil {
            pronounciationTextView.text = word.phonetics?.first?.text
            audioPronounciationLink.text = word.phonetics?.first?.audio.trimmingCharacters(in: CharacterSet(charactersIn: "//"))
        } else {
            pronounciationTextView.text = "Произношение недоступно"
            audioPronounciationLink.text = "Аудиопроизношение недоступно"
        }
        var meaningsArray: [String] = []
        for i in 0..<word.meanings.count {
            meaningsArray.append("⚫️  Значение №\(i+1)")
            meaningsArray.append("Часть речи: \(word.meanings[i].partOfSpeech)")
            for j in 0..<word.meanings[i].definitions.count {
                meaningsArray.append("Определение: \(word.meanings[i].definitions[j].definition)")
                meaningsArray.append("  Пример в речи: \(word.meanings[i].definitions[j].example ?? "не найдено 😔")")
                if let synonyms = word.meanings[i].definitions[j].synonyms {
                    meaningsArray.append("  Синонимы: ")
                    for k in 0..<synonyms.count {
                        meaningsArray.append("  \(word.meanings[i].definitions[j].synonyms?[k] ?? "не найдено 😔")")
                    }
                }
                if let antonyms = word.meanings[i].definitions[j].antonyms {
                    meaningsArray.append("  Антонимы: ")
                    for k in 0..<antonyms.count {
                        meaningsArray.append("  \(word.meanings[i].definitions[j].antonyms?[k] ?? "не найдено 😔")")
                    }
                }
            }
        }
        meaningsAndDataTextView.text = meaningsArray.joined(separator: "\n")
    }
}
