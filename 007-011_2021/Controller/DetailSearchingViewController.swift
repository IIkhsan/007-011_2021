//
//  DetailSearchingViewController.swift
//  007-011_2021
//
//  Created by Тимур Миргалиев on 25.11.2021.
//

import UIKit
import AVFoundation

class DetailSearchingViewController: UIViewController {
    
    var word: Word?
    
    private let dataSoreManager = DataStoreManager()
    private let musicFounder = NetworkManager()
    
    //MARK: - UI
    @IBOutlet weak var generalWord: UILabel!
    @IBOutlet weak var phoneticOfWord: UILabel!
    @IBOutlet weak var originOfWord: UILabel!
    @IBOutlet weak var saveButton: UIButton!

    var audioUrl: URL?
    var player: AVPlayer?
    
    
    //MARK: - Life ........
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generalWord.text = word?.word
        phoneticOfWord.text = word?.phonetic
        if dataSoreManager.isContains(word: word!) {
            saveButton.isHidden = true
        } 
        if word?.origin == nil {
            originOfWord.text = "No such origin"
        } else {
            originOfWord.text = word?.origin
        }
        
        var urlString: String = ""
        let phonetics: [Phonetics]? = word?.phonetics
        if phonetics?.count ?? 0 > 0 {
            urlString = phonetics![0].audio ?? ""
            audioUrl = URL(string: "https:\(urlString)")
        }
        
    }
    
    @IBAction func didClickPlayWord(_ sender: Any) {        
        guard let url = audioUrl else { return }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
    }
    
    @IBAction func didClickSaveButton(_ sender: UIButton) {
        dataSoreManager.addCdWord(word: word!)
        saveButton.isHidden = true
    }
}
