//
//  ViewController.swift
//  TUTORIAL_05
//
//  Created by saera on 2018. 7. 9..
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

    @IBOutlet var email: UITextField!
    @IBOutlet var isUpdate: UISwitch!
    @IBOutlet var interval: UIStepper!
    
    @IBOutlet var isUpdateText: UILabel!
    @IBOutlet var intervalText: UILabel!

    @IBAction func onSwitch(_ sender: UISwitch) {
        //옵셔널 캐스팅(sender 가 Any 인 경우)
        //guard let obj = sender as? UISwitch else { return }
        
        if(sender.isOn == true) {
            self.isUpdateText.text = "갱신함"
        } else {
            self.isUpdateText.text = "갱신하지 않음"
        }
    }
    
    @IBAction func onStepper(_ sender: UIStepper) {
        //강제 캐스팅(sender 가 Any인 경우)
        //let obj = sender as! UIStepper
        let value = Int(sender.value)
        self.intervalText.text = "\(value)분 마다"
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "RVC") as? ResultViewController else {
            return
        }
        
        rvc.paramEmail = self.email.text!
        rvc.paramUpdate = self.isUpdate.isOn
        rvc.paramInterval = self.interval.value
        
        //버튼 이용
//        self.present(rvc, animated: true)
        //네비게이션 컨트롤러 이용
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    
    @IBAction func onPerformSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "ManualSubmit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //목적지 뷰 컨트롤러 인스턴스 읽어오기
        let dest = segue.destination
        guard let rvc = dest as? ResultViewController else {
            return
        }
        
        //값 전달
        rvc.paramEmail = self.email.text!
        rvc.paramUpdate = self.isUpdate.isOn
        rvc.paramInterval = self.interval.value
    }
    

    
}

