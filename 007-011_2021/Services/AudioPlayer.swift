//
//  AudioPlayer.swift
//  007-011_2021
//
//  Created by andrewoch on 19.12.2021.
//

import Foundation
import AVFoundation

class AudioPlayer: AudioPlayerProtocol {

    // MARK: - Properties
    private var player: AVPlayer?

    // MARK: - Public methods
    func playAudio(using audioURL: String) {
        let formattedAudioURL = "https:" + audioURL
        guard let url = URL(string: String(formattedAudioURL)) else { return }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }

}
