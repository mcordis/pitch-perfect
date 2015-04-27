//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Monique Cordis on 4/26/15.
//  Copyright (c) 2015 Udacity and Monique Cordis. All rights reserved.
//

//Foundation is a framework in iOS like UIKit and has important classes like defining String or an Array

import Foundation

//this class inherits from NSObject which is the root class for most classes in iOS

class RecordedAudio: NSObject{
    
    var filePathUrl: NSURL!
    
    var title: String!
    
    //crated a method for the RecordedAudio class to be used in code
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
}