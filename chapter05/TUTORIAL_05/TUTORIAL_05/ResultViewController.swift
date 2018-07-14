//
//  ResultViewController.swift
//  TUTORIAL_05
//
//  Created by saera on 2018. 7. 9..
//  Copyright © 2018년 OnlyNew. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var resultEmail: UILabel!
    @IBOutlet var resultUpdate: UILabel!
    @IBOutlet var resultInterval: UILabel!
    
    var paramEmail: String = ""
    var paramUpdate: Bool = false
    var paramInterval: Double = 0
    
    override func viewDidLoad() {
        self.resultEmail.text = paramEmail
        self.resultUpdate.text = (self.paramUpdate == true ? "자동갱신" : "자동갱신 안함")
        self.resultInterval.text = "\(Int(self.paramInterval))분 마다"
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
}
