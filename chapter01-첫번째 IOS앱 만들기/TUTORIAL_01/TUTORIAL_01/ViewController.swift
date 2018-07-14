//
//  ViewController.swift
//  TUTORIAL_01
//
//  Created by saera on 2018. 7. 3..
//  Copyright © 2018년 OnlyNew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var uiTitle: UILabel!
    
    @IBAction func sayHello(_ sender: Any) {
        self.uiTitle.text = "Hello, World!"
    }
}

