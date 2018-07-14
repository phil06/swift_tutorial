//
//  ViewController.swift
//  TUTORIAL_05_2
//
//  Created by saera on 2018. 7. 11..
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

    @IBOutlet var resultEmail: UILabel!
    @IBOutlet var resultUpdate: UILabel!
    @IBOutlet var resultInterval: UILabel!
    
    var paramEmail: String?
    var paramUpdate: Bool?
    var paramInterval: Double?
    
    override func viewWillAppear(_ animated: Bool) {
        //뷰컨트롤러를 통한 값 직접 전달
//        if let email = paramEmail {
//            resultEmail.text = email
//        }
//        if let update = paramUpdate {
//            resultUpdate.text = update == true ? "자동갱신" : "자동갱신 안함"
//        }
//        if let interval = paramInterval {
//            resultInterval.text = "\(Int(interval))분 마다"
//        }
        
        //delegate 를 이용한 값 전달
//        //AppDelegate객체의 인스턴스를 가져온다
//        let ad = UIApplication.shared.delegate as? AppDelegate
//
//        if let email = ad?.paramEmail {
//            resultEmail.text = email
//        }
//        if let update = ad?.paramUpdate {
//            resultUpdate.text = update == true ? "자동갱신" : "자동갱신 안함"
//        }
//        if let interval = ad?.paramInterval {
//            resultInterval.text = "\(Int(interval))분 마다"
//        }
        
        //UserDefault 를 이용한 값 전달
        //UserDefault 객체의 인스턴스를 가져온다
        let ud = UserDefaults.standard
        
        if let email = ud.string(forKey: "email") {
            resultEmail.text = email
        }
        
        let update = ud.bool(forKey: "isUpdate")
        resultUpdate.text = (update == true ? "자동갱신" : "자동갱신 안함")
        
        let interval = ud.double(forKey: "interval")
        resultInterval.text = "\(Int(interval))분 마다"
    }

}

