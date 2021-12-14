//
//  SavingWordViewController.swift
//  007-011_2021
//
//  Created by Artem Kalugin on 09.12.2021.
//

import UIKit
import AVFoundation

class SavingWordViewController: UIViewController {
    // Outlet properties
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var playAudioLabel: UILabel!
    @IBOutlet weak var playAudioButton: UIButton!
    
    // public properties
    var word: Word?
    
    // private properties
    private let dataStoreInteractor = DataStoreInteractor()
    private var player: AVPlayer?
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Button actions
    @IBAction func saveButtonAction(_ sender: Any) {
        guard let guardWord = word else { return }
    
        dataStoreInteractor.saveWord(word: guardWord)
        saveButton.isEnabled = false
    }
    
    @IBAction func playAudioButtonAction(_ sender: Any) {
        guard let guardWord = word else { return }
        let guardPhonetics = guardWord.phonetics ?? []
        let audio = guardPhonetics[0].audio ?? nil
        
        if audio != nil {
            guard let url = URL(string: "https:\(audio ?? "")") else { return }
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer.init(playerItem: playerItem)
            player?.play()
        }
    }
    
    // MARK: - Private functions
    private func configure() {
        guard let guardWord = word else { return }
        let guardMeanings = guardWord.meanings ?? []
        let guardPhonetics = guardWord.phonetics ?? []
        
        if !guardMeanings.isEmpty {
            let definitions = guardMeanings[0].definitions ?? []
            
            if !definitions.isEmpty {
                definitionLabel.text = definitions[0].definition
            } else {
                definitionLabel.text = "Can't find a definition!"
            }
        }
        
        if !guardPhonetics.isEmpty {
            let phonetic = guardPhonetics[0]
            
            if phonetic.audio == nil {
                playAudioLabel.text = "No audio"
                playAudioButton.isEnabled = false
            }
        }
        
        if dataStoreInteractor.isContainsWord(word: guardWord) {
            saveButton.isEnabled = false
        }
        
        
    }
}
