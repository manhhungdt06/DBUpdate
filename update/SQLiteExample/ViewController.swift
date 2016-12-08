//
//  ViewController.swift
//  SQLiteExample
//
//  Created by techmaster on 12/5/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    let database = DataBase.sharedInstance
    
    var words = [Word]()
    
    var allWords = [NSDictionary]()
    
    var statement = ""

    var backView: UIView!
    var back: UIImageView!
    var isFront = true
    
    var viewBgr: UIView!
    var wordText, typeText, pronunText, sentenText, meanText: UITextView!
    var audio = AVAudioPlayer()

    var index = 0
    @IBOutlet var countDownLabel: UILabel!
    
    var count = 10    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func loadData(_ sender: UIButton) {
        allWords = database.viewDB("WORDS", ["ID", "word", "mean", "type", "sentence", "vocal", "sound", "image", "synonym", "time"], statement)
        
        for word in allWords {
            words.append(Word(id: word["ID"] as! Int, word: word["word"] as! NSString, mean: word["mean"] as! NSString, type: word["type"] as! NSString, sentence: word["sentence"] as! NSString, vocal: word["vocal"] as! NSString, sound: word["sound"] as! NSString, img: word["image"] as! NSString, synonym: word["synonym"] as! NSString, time: word["time"] as! Int))
        }
    }
    
    @IBAction func startRun(_ sender: UIButton) {
        
        changeContent(key: index, colorGroup: "ColorGroup2", wordType: "wordFont1")
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addWord(_ sender: UIButton) {
        // insert word
        database.insertDB("WORDS", ["word": "abbreviate", "mean": "viết tắt", "type": "verb", "sentence": "In writing, the title \"Doctor\" is abbreviated to \"Dr\".", "vocal": "/ əˈbriːvieɪt /", "sound": "abbreviate_v", "image": "abbreviate.jpeg", "synonym": "shorten"])
        
        database.insertDB("WORDS", ["word": "absorb", "mean": "hấp thụ", "type": "verb", "sentence": "If you stay out in the sun too long, UV radiation will be absorbed into your skin and causes skin cancer.", "vocal": "/ əbˈsɔːrb /", "sound": "absorb_v", "image": "absorb.jpeg", "synonym": "imbibe"])
        
        database.insertDB("WORDS", ["word": "accommodate", "mean": "cung cấp nơi ở", "type": "verb", "sentence": "I was accommodated in this hotel during my business trip.", "vocal": "/ əˈkɑːmədeɪt /", "sound": "accommodate_v", "image": "accommodate.jpeg", "synonym": "house"])
        
        database.insertDB("WORDS", ["word": "accomplish", "mean": "hoàn thành", "type": "verb", "sentence": "Surprisingly, the students accomplished the 30-minute test in only less than ten minutes.", "vocal": "/ əˈkɑːmplɪʃ /", "sound": "accomplish_v", "image": "accomplish.jpeg", "synonym": "complete"])
    }
    
    @IBAction func deleteDB(_ sender: UIButton) {
        database.deleteDB("WORDS", 3)
    }
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 8, y: 9, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func createText(_ textView: UITextView,_ text: NSString,_ color: UIColor,_ font: UIFont) {
        textView.text = text as String
        //        textView.textColor = colorText // colorText: UIColor
        textView.font = font
        textView.backgroundColor = color
        textView.textAlignment = .center
        textView.isEditable = false
    }
    
    
    func tapped() {
        if (isFront) {
            UIView.transition(from: wordText, to: backView, duration: 1, options: UIViewAnimationOptions.transitionFlipFromRight, completion: nil)
        } else {
            UIView.transition(from: backView, to: wordText, duration: 1, options: UIViewAnimationOptions.transitionFlipFromLeft, completion: nil)
        }
        isFront = !isFront
    }
    
    @IBAction func action_play(_ sender: UIButton) {
        audio.play()
    }
    
    func update() {

        if(count > 0) {
            count -= 1
            countDownLabel.text = String(count)
        }
        if count == 0 {
            index += 1
            if index == words.count {
                index = 0
            }
            changeContent(key: index, colorGroup: "ColorGroup2", wordType: "wordFont1")
            count = 10
        }
    }
    @IBAction func nextWord(_ sender: UIButton) {
        index += 1
        if index == words.count {
            index = 0
        }
        changeContent(key: index, colorGroup: "ColorGroup2", wordType: "wordFont1")
        count = 10
    }
    
    func changeContent(key: Int, colorGroup: String, wordType: String) {
        isFront = true
        var groupColors = [Int]()
        var wordFontNames = [String]()
        var sentenFontNames = [String]()
        
        switch colorGroup {
        case "ColorGroup1":
            groupColors = [0xeadccf, 0xdedfd5, 0x32ba14, 0xdde663, 0xaab469, 0x273c4d, 0x8b5939, 0xa39ba0, 0x4b5445, 0xd2ba7c]
            break
        case "ColorGroup2":
            groupColors = [0xffdd91, 0xd6b2a5, 0xb093a3, 0x787492, 0x282e54, 0xcbffcb, 0x407949, 0x3d9891, 0xcef2c6, 0xb4ad81]
            break
        case "ColorGroup3":
            groupColors = [0xd5f2ac, 0xe3b505, 0xf9f2ea, 0x0c8895, 0xe4e550, 0xa3bb67, 0x80d0d2, 0x7b776f, 0x008141, 0x869c5f]
            break
        case "ColorGroup4":
            groupColors = [0xae96b3, 0x96626e, 0xf1faf0, 0x5e6083, 0x6a7a90, 0x7fa643, 0xe5f2c9, 0x7fa643, 0x3c5940, 0xf2d9ba]
            break
        case "ColorGroup5":
            groupColors = [0xb1c9a5, 0x94c595, 0x54944a, 0xcc7f40, 0x9ccafb, 0xf0f4fd, 0xdeb343, 0xfedf71, 0xe6f287, 0xebeff2]
            break
        default:
            print("not found color")
        }
        
        switch wordType {
        case "wordFont1":
            wordFontNames = ["Avenir-BlackOblique", "Baskerville-BoldItalic", "ChalkboardSE-Bold", "Superclarendon-BoldItalic"]
            sentenFontNames = ["GillSans-LightItalic", "Palatino-Italic"]
        case "wordFont2":
            wordFontNames = ["ChalkboardSE-Bold", "MarkerFelt-Thin", "Verdana-Bold", "Baskerville-BoldItalic"]
            sentenFontNames = ["BodoniSvtyTwoOSITCTT-BookIt", "Didot-Italic"]
        case "wordFont3":
            wordFontNames = ["Superclarendon-BoldItalic", "Verdana-Bold", "Baskerville-BoldItalic", "ChalkboardSE-Bold"]
            sentenFontNames = ["Noteworthy-Light", "HelveticaNeue-LightItalic"]
        default:
            print("none")
        }
        
        if viewBgr != nil && backView != nil {
            viewBgr.removeFromSuperview()
            backView.removeFromSuperview()
        }
        
        audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: words[key].sound! as String, ofType: "mp3")!))
        audio.delegate = self
        audio.prepareToPlay()
        
        wordText = UITextView(frame: CGRect(x: 8, y: 9, width: 328, height: 130))
        createText(wordText, words[key].word!, UIColor.init(netHex: groupColors[Int(arc4random_uniform(10))]), UIFont.init(name: wordFontNames[Int(arc4random_uniform(4))], size: 40)!)
        
        
        typeText = UITextView(frame: CGRect(x: 8, y: 147, width: 100, height: 51))
        createText(typeText, words[key].type!, UIColor.init(netHex: groupColors[Int(arc4random_uniform(10))]), UIFont.init(name: "Menlo-Regular", size: 19)!)
        
        pronunText = UITextView(frame: CGRect(x: 116, y: 147, width: 220, height: 51))
        createText(pronunText, words[key].vocal!, UIColor.init(netHex: groupColors[Int(arc4random_uniform(10))]), UIFont.init(name: "Menlo-Regular", size: 19)!)
        
        sentenText = UITextView(frame: CGRect(x: 8, y: 226, width: 328, height: 114))
        createText(sentenText, words[key].sentence!, UIColor.init(netHex: groupColors[Int(arc4random_uniform(10))]), UIFont.init(name: sentenFontNames[Int(arc4random_uniform(2))], size: 20)!)
        
        let rect1 = CGRect(x: 8, y: 9, width: 340, height: 280)
        
        back = UIImageView(frame: rect1)
        let wordImg = UIImage(named: words[key].img! as String)
        
        let newBackImg = ResizeImage(image: wordImg!, targetSize: CGSize(width: 340, height: 280))
        back = UIImageView(image: newBackImg)
        meanText = UITextView(frame: CGRect(x: 8, y: 226, width: 328, height: 114))
        createText(meanText, words[key].mean!, UIColor.init(netHex: groupColors[Int(arc4random_uniform(10))]), UIFont.init(name: "HelveticaNeue-Italic", size: 40)!)
        let rect2 = CGRect(x: 0, y: 0, width: 344, height: 299)
        backView = UIView(frame: rect2)
        
        backView.addSubview(back)
        backView.addSubview(meanText)
        
        let rect = CGRect(x: 16, y: 100, width: 344, height: 358)
        viewBgr = UIView(frame: rect)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        singleTap.numberOfTapsRequired = 1
        
        viewBgr.addGestureRecognizer(singleTap)
        viewBgr.isUserInteractionEnabled = true
        
        viewBgr.addSubview(wordText)
        viewBgr.addSubview(typeText)
        viewBgr.addSubview(pronunText)
        viewBgr.addSubview(sentenText)
        view.addSubview(viewBgr)
        
        audio.play()
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
