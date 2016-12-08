//
//  ViewController.swift
//  readWriteData
//
//  Created by techmaster on 12/7/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var word: UITextField!
    
    @IBOutlet weak var type: UITextField!
    
    @IBOutlet weak var mean: UITextField!
    
    @IBOutlet weak var vocal: UITextField!
    
    @IBOutlet weak var sen: UITextField!
    
    @IBOutlet weak var syn: UITextField!
    
    @IBOutlet weak var imgView: UIImageView!
    
    var img: String = ""
    var sound: String = ""
    var filePath: String = ""
    var fileURL: URL!
    var item: item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // NSURL(fileURLWithPath: userInfoPath) as URL
        
        filePath = getPath("/exam.plist")
        let tempData:[String: NSDictionary] = [:]
        
        if (!FileManager.default.fileExists(atPath: filePath) ) {
            let temp = NSDictionary(dictionary: tempData)
            temp.write(toFile: filePath, atomically: true)
        }
        
        fileURL = NSURL(fileURLWithPath: filePath) as URL
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPath(_ fileName: String) -> String {
        
        let userFileDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let userInfoPath = userFileDir.appending(fileName)
        
        print("userInfoPath = \(userInfoPath)")
        
        return userInfoPath
        
    }
    
    @IBAction func getImg(_ sender: UIButton) {
        
    }
    
    @IBAction func readData(_ sender: UIButton) {
        
        let tempData = NSMutableDictionary(contentsOf: fileURL)
        
        for i in tempData!.allKeys {
            let dict = NSDictionary(dictionary: tempData![i] as! Dictionary)
            for j in dict.allKeys {
                print("\(j) = \(dict[j]!)")
            }
        }
        
    }
    @IBAction func save(_ sender: UIButton) {
        if word.text == "" || type.text == "" || mean.text == "" || vocal.text == "" || sen.text == "" || syn.text == "" {
            print("ko de trong")
        }
        else {
            if type.text == "verb" {
                sound = word.text! + "_v"
            }
            img = word.text! + ".jpeg"
            
            var data :Dictionary<String,Any> = [:]
            
            data["sentence"] = sen.text!
            data["meaning"] = mean.text!
            data["vocalization"] = vocal.text!
            data["type"] = type.text!
            data["synonym"] = syn.text!
            data["image"] = img
            data["sound"] = sound
            data["time"] = 86400
            
            // if file exist
            
            let dataWord = NSMutableDictionary(contentsOf: fileURL)
            
            dataWord?[word.text! as String] = data as NSDictionary
            dataWord?.write(to: fileURL, atomically: true)
            
            sen.text = ""
            mean.text = ""
            vocal.text = ""
            type.text = ""
            word.text = ""
            syn.text = ""
        }
    }
    
}

