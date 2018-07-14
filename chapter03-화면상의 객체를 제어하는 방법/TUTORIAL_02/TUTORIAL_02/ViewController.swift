//
//  ViewController.swift
//  TUTORIAL_02
//
//  Created by saera on 2018. 7. 7..
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

    @IBOutlet var uiTitle01: UILabel!
    @IBOutlet var uiTitle02: UILabel!
    @IBOutlet var uiTitle03: UILabel!
    @IBOutlet var uiTitle04: UILabel!
    @IBOutlet var uiTitle05: UILabel!
    
    @IBAction func clickBtn01(_ sender: Any) {
        self.uiTitle01.text = "Button01 clicked"
    }
    @IBAction func clickBtn02(_ sender: Any) {
        self.uiTitle02.text = "Button02 clicked"
    }
    @IBAction func clickBtn03(_ sender: Any) {
        self.uiTitle03.text = "Button03 clicked"
    }
    @IBAction func clickBtn04(_ sender: Any) {
        self.uiTitle04.text = "Button04 clicked"
    }
    @IBAction func clickBtn05(_ sender: Any) {
        self.uiTitle05.text = "Button05 clicked"
    }
    
}

