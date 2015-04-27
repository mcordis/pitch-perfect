//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Udacity and Monique Cordis on 4/25/15.
//  Copyright (c) 2015 Monique Cordis. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordLabel: UILabel!

    @IBOutlet weak var stopRecording: UIButton!
    
   @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    //create new object for class that was created RecordedAudio so that I can record sound
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //to hide the stop button once the app first launches
        //add method viewWillAppear inherited from UIViewCOntroller that's why keyword override is being used
        
        stopRecording.hidden = true
        
    }

    @IBAction func recordAudio(sender: UIButton) {
        
        recordLabel.text = "recording"
        
        stopRecording.hidden = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        var currentDateTime = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        var recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        var pathArray = [dirPath, recordingName]
        
        let filePath = NSURL.fileURLWithPathComponents(pathArray)

        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        println(filePath)
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool)
    {
        
        if(flag){
            //Step 1 - save the recorded audio (title and path stored on the phone). Create  a new class call RecordedAudio. Reference the recordedAudio class
            //initialize new object
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            
            //Step 2 - Move th next scene aka perfom segue. Next scene inherit from UIViewController. Use ID of segue (link ID). recordedAudio initiates the segue
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else
        {
            println("Recording was not successful")
            
            stopRecording.hidden = true
        }
        
    }
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "stopRecording")
        {
            //created a constant called playSoundsVC. Used as! keyword to convert to playsoundsviewcontroller type. pass data to 2nd view controller.
            //sender initiates segue (recordedAudio). Retreive data from sender. Pass data to playSoundsVC (View controller)
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            
            //created a variable in PlaySoundsViewController.swift so that the class can handle getting data passed to it
            playSoundsVC.receivedAudio = data
        
        }
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        
        audioRecorder.stop() //need to stop recording otherwise the the recording is still streaming in input and recording will not save
        recordLabel.text = "Tap to record"
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
    
}

