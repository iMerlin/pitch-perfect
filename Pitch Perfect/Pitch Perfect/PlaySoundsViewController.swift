//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by iMac on 3/11/15.
//  Copyright (c) 2015 Merlin. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer : AVAudioPlayer!
    var receivedAudio : RecordedAudio!
    var audioEngine : AVAudioEngine!
    var audioFile : AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = AVAudioSession.sharedInstance()
        var error: NSError?
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error)
        session.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: &error)
        session.setActive(true, error: &error)

        
        audioEngine = AVAudioEngine()
        audioPlayer = AVAudioPlayer (contentsOfURL: receivedAudio.filePathURL, error: nil)
        audioPlayer.enableRate = true
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func slowPlaybackPressed(sender: UIButton) {
   
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        //Lesson states its good practice to stop the audio player before we play it
        audioPlayer.rate = 0.5
        //audioPlayer.currentTime = 0.0
        //Use to reset time in playback of audio
        audioPlayer.play()
        
        
    }
    
    
    @IBAction func fastPlaybackPressed(sender: UIButton) {
        
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer.rate = 2.0
        audioPlayer.play()

    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)

        
    }
    
    @IBAction func playVaderAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(-500)

    }
    
    
    func playAudioWithVariablePitch(pitch: Float) {
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    
    
    
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        
        audioPlayer.stop()

        
    }


}
