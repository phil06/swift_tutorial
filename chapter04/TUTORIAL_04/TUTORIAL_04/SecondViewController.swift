//
//  SecondViewController.swift
//  TUTORIAL_04
//
//  Created by saera on 2018. 7. 8..
//  Copyright © 2018년 OnlyNew. All rights reserved.
//


import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
