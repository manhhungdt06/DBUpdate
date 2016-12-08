//
//  ViewController.swift
//  PassingDataExam
//
//  Created by techmaster on 12/6/16.
//  Copyright © 2016 techmaster. All rights reserved.
//

import UIKit


struct Data {
    var param1: Int?
}

class MainViewController: UIViewController {

    var model: Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    when a segue is performed
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let data = Data(param1: 5)
        if(segue.identifier == "showCont") {
            let des = segue.destination as! SubViewController
            des.data = data
        }
    }
    
//    @IBAction func presentNew(_ sender: UIButton) {
//        presentDesView()
//    }
//    func presentDesView() {
//        let data = Data(param1: 10)
//        let desView = SubViewController(nibName: "Main", bundle: nil)
//        desView.data = data
//        present(desView, animated: true, completion: nil)
//    }

}

