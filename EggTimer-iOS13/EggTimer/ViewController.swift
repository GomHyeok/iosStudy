//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressbar: UIProgressView!
    @IBOutlet weak var titleLable: UILabel!
    private let eggTimes = ["Soft" : 600, "Medium" : 720, "Hard" : 900]
    
    private var totalTime = 0
    private var secondsPassed = 0
    private var timer = Timer()
    private var soundEffect : AVAudioPlayer?
    
    @IBAction func hardSelect(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        timer.invalidate()
        
        titleLable.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        if totalTime >= secondsPassed {
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressbar.progress = percentageProgress
            secondsPassed+=1
        }
        else{
            secondsPassed = 0
            totalTime = 0
            playAudio()
            timer.invalidate()
            titleLable.text =  "DONE!"
        }
    }
    
    func playAudio() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: ".mp3")
        
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url!)
            guard let sound = soundEffect else { return }
            sound.play()
            } catch let error {
                print(error.localizedDescription)
            }
        
    }

}
