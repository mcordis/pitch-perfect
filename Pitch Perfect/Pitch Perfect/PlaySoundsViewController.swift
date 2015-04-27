//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Udacity and Monique Cordis on 4/26/15.
//  Copyright (c) 2015 Monique Cordis. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    //set a global var for audioPlayer is of type AVAudioPlayer
    var audioPlayer:AVAudioPlayer!
    
     //created a variable so that this class can handle getting data passed to it
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //no longer referencing movie quote mp3. Want to use data from recording instead which gets passed to variable receivedAudio from ViewController.swift
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playSlowSounds(sender: AnyObject) {
        
       //good practice to stop the audio player before you play it
        audioPlayer.stop()
        audioEngine.stop()
        
        //restart the audio at the beginning
        audioPlayer.currentTime = 0.0
        
        //change the speed rate of the sound to be slow
        audioPlayer.rate = 0.5
        
        //play the mp3 file
        audioPlayer.play()
        
    }
   
    @IBAction func playFastSounds(sender: UIButton) {
        
        //good practice to stop the audio player before you play it
        audioPlayer.stop()
        audioEngine.stop()
        
        //change the speed rate of the sound to be fast
        audioPlayer.rate = 2
        
        //restart the audio at the beginning
        audioPlayer.currentTime = 0.0
        
        //play the mp3 file
        audioPlayer.play()
    }

    @IBAction func playChipmunkAudio(sender: UIButton) {
        
       //runs when press button
        playAudioWithVariablePitch(1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        //stop all audio before playing the audio back again
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        //attach audio player node to engine
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        //set the pitich
        
        //attach pitch effect to engine
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        //connect audio player node to pitch effect and pitch effet to output speaker
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        //play sound
        audioPlayerNode.play()
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
        
    }
    
    
    @IBAction func stopAudio(sender: AnyObject) {
        //stop audio
        audioPlayer.stop()
        audioEngine.stop()
    }
    
}
