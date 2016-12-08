//
//  Word.swift
//  SQLiteExample
//
//  Created by techmaster on 12/8/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

import Foundation

class Word: NSObject {
    var id: Int!
    var word: NSString!
    var mean: NSString!
    var type: NSString!
    var sentence: NSString!
    var vocal: NSString!
    var sound: NSString!
    var img: NSString!
    var synonym: NSString!
    var time: Int!
    
    override init() {
        id = 0
        word = ""
        mean = ""
        type = ""
        sentence = ""
        vocal = ""
        sound = ""
        img = ""
        synonym = ""
        time = 0
    }
    
    init(id: Int, word: NSString, mean:NSString, type: NSString, sentence: NSString, vocal: NSString, sound: NSString, img: NSString, synonym: NSString, time: Int) {
        self.id = id
        self.word = word
        self.mean = mean
        self.type = type
        self.sentence = sentence
        self.vocal = vocal
        self.sound = sound
        self.img = img
        self.synonym = img
        self.time = time
    }
}
