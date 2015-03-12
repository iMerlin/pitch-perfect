//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by iMac on 3/12/15.
//  Copyright (c) 2015 Merlin. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathURL: NSURL
    var title: String
    
    init(filePathURL: NSURL, title: String) {
        self.filePathURL = filePathURL
        self.title = title
    }
}