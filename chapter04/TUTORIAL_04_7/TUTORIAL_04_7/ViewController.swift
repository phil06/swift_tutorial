//
//  ViewController.swift
//  TUTORIAL_04_7
//
//  Created by saera on 2018. 7. 8..
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        NSLog("세그웨이가 곧 실행됩니다")
        NSLog("segueway identifier: \(String(describing: segue.identifier))")
        if(segue.identifier == "custom_segue") {
            NSLog("커스텀 세그가 실행되었음요")
        }
    }

}

