//
//  File.swift
//  PassingDataExam
//
//  Created by techmaster on 12/6/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

import Foundation


// save data? instead of hash code class property

class Model: NSObject {
    var name: String?
    init(name: String) {
        self.name = name
    }
}
