//
//  item.swift
//  readWriteData
//
//  Created by techmaster on 12/7/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

import Foundation

class item: NSObject {
    var text: String?
    var sentence: String?
    var meaning: String?
    var type: String?
    var vocal: String?
    var sound: String?
    var image: String?
    var synonym: String?
    var time: Int?
    
    init(text: String, sentence: String, meaning: String, type: String, vocal: String, sound: String, image: String, synonym: String, time: Int) {
        
        self.text = text
        self.sentence = sentence
        self.meaning = meaning
        self.type = type
        self.vocal = vocal
        self.sound = sound
        self.image = image
        self.synonym = synonym
        self.time = time
    }
}
