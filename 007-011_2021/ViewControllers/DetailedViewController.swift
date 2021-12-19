//
//  DetailedViewController.swift
//  007-011_2021
//
//  Created by andrewoch on 09.12.2021.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var word : Word?
    var saved: Bool?
    
    private var audioPlayer: AudioPlayerProtocol = AudioPlayer()
    
    var wordSaveAction: ((Word) -> Void)? = nil
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var phoneticLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    
    @IBOutlet weak var phoneticPlayButton: UIButton!
    @IBOutlet weak var addToFavouritesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordLabel.text = word?.word
        phoneticLabel.text = word?.phonetic
        originLabel.text = word?.origin
        
        if(saved ?? true){
            addToFavouritesButton.isHidden = true
        }
    }
    
    @IBAction func playPhonetics(_ sender: Any) {
        guard let phonetics = word?.phonetics else {return}
        
        if (phonetics.first?.audio != nil){
            audioPlayer.playAudio(using: phonetics.first?.audio ?? "")
        }
    }
    
    @IBAction func addToFavourites(_ sender: UIButton) {
        guard let word = word, let saveAction = wordSaveAction else {
            return
        }
        saveAction(word)
        self.dismiss(animated: true, completion: nil)
    }
    
}
