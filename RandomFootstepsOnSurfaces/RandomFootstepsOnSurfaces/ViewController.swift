//
//  ViewController.swift
//  AVFoundation Blog2
//
//  Created by Lawrence Herman on 2/3/17.
//  Copyright © 2017 Lawrence Herman. All rights reserved.
//

import UIKit
import AVFoundation

enum SurfaceSpeedType: String {
    case dirtWalk, dirtRun, grassWalk, grassRun
}

struct SoundEffect {
    var player: AVAudioPlayer
    var surfaceSpeed: SurfaceSpeedType
}

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var index = 0
    var shouldKeepPlaying = true
    
    var sounds = [SoundEffect]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSounds()
    }
    
    func loadSounds() {
        
        let surfaceTypeArray: [SurfaceSpeedType] = [.dirtWalk, .dirtRun, .grassWalk, .grassRun]
        
        surfaceTypeArray.forEach { (soundtype) in
            for i in 1...6 {
                let path = Bundle.main.path(forResource: "\(soundtype)\(i)", ofType: "mp3")!
                let url = URL(fileURLWithPath: path)
                let sound = try! AVAudioPlayer(contentsOf: url)
                let soundEffect = SoundEffect(player: sound, surfaceSpeed: soundtype)
                soundEffect.player.delegate = self
                sounds.append(soundEffect)
            }
        }
    }
    
    func playSound(ofType soundEffect: SurfaceSpeedType) {
      let filteredSounds =  sounds.filter { $0.surfaceSpeed == soundEffect }
        index = Int(arc4random_uniform(UInt32(filteredSounds.count)))
        filteredSounds[index].player.play()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        let soundEffect = sounds.filter{ $0.player == player }
        if let first = soundEffect.first {
            playSounds(ofType: first.surfaceSpeed)
        }
    }
    
    func playSounds(ofType soundEffect: SurfaceSpeedType) {
        let filteredSounds = sounds.filter { $0.surfaceSpeed == soundEffect }

        if !shouldKeepPlaying {
            index = Int(arc4random_uniform(UInt32(filteredSounds.count)))
            filteredSounds[index].player.play()
        }
    }
    
    @IBAction func dirtWalk(_ sender: UIButton) {
        shouldKeepPlaying = !shouldKeepPlaying
        playSound(ofType: .dirtWalk)
    }
 
    @IBAction func dirtWalkStop(_ sender: UIButton) {
        
        shouldKeepPlaying = !shouldKeepPlaying
    }
    
    @IBAction func dirtRun(_ sender: UIButton) {
        
        shouldKeepPlaying = !shouldKeepPlaying
        playSound(ofType: .dirtRun)
    }

    @IBAction func dirtRunStop(_ sender: UIButton) {
        shouldKeepPlaying = !shouldKeepPlaying
    }
    
    @IBAction func grassWalk(_ sender: UIButton) {
        shouldKeepPlaying = !shouldKeepPlaying
        playSound(ofType: .grassWalk)
    }
    
    @IBAction func grassWalkStop(_ sender: UIButton) {
        shouldKeepPlaying = !shouldKeepPlaying
    }
   
    @IBAction func grassRun(_ sender: UIButton) {
        shouldKeepPlaying = !shouldKeepPlaying
        playSound(ofType: .grassRun)
    }
    
    @IBAction func grassRunStop(_ sender: UIButton) {
        shouldKeepPlaying = !shouldKeepPlaying
        print("grassRun Stop")
    }
}
