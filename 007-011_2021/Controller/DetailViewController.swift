//
//  DetailViewController.swift
//  007-011_2021
//
//  Created by Илья Желтиков on 15.12.2021.
//

import AVFoundation
import UIKit

class DetailViewController: UIViewController {

    //MARK: - Properties
    var word: Word?
    private let dataSoreManager = DataStoreManager()
    private let musicFounder = NetworkManager()
    private var audioUrl: URL?
    private var player: AVPlayer?
    
    //MARK: - IBOutlets
    @IBOutlet weak var wordTitle: UILabel!
    @IBOutlet weak var wordPhonetic: UILabel!
    @IBOutlet weak var wordOrigin: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func audioButton(_ sender: Any) {
        guard let url = audioUrl else { return }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        addButton.isHidden = true
        dataSoreManager.addCdWord(word: word!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    
    //MARK: - Funcs
    func configure() {
        wordTitle.text = word?.word
        wordPhonetic.text = word?.phonetic
        if dataSoreManager.isContains(word: word!) {
            addButton.isHidden = true
        }
        if word?.origin != nil {
            wordOrigin.text = word?.origin
        } else {
            wordOrigin.text = "No info about origin :("
        }
        
        var urlString: String = ""
        let phonetics: [Phonetics]? = word?.phonetics
        if phonetics?.count ?? 0 > 0 {
            urlString = phonetics![0].audio ?? ""
            audioUrl = URL(string: "https:\(urlString)")
        }
    }
}
