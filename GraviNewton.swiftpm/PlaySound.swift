//
//  File.swift
//  GraviNewton
//
//  Created by Cynara Costa on 13/04/22.
//

import SwiftUI
import AVFoundation

var player: AVAudioPlayer!

func playSound(sound: String) {
    let url = Bundle.main.url(forResource: sound, withExtension: "mp3")
    
    guard url != nil else {
        return
    }
    
    do {
        
        player = try AVAudioPlayer(contentsOf: url!)
        player.volume = 0.8
        
        if sound == "hitSound"{
            player?.play()
        
        } else if sound == "ideaSound"{
            player?.play()
        
        } else {
            player.numberOfLoops = -1
            player?.play()
        }
        
    } catch {
        print("error")
    }
    
}
