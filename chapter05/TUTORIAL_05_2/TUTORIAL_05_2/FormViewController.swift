//
//  FormViewController.swift
//  TUTORIAL_05_2
//
//  Created by saera on 2018. 7. 11..
//  Copyright © 2018년 OnlyNew. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var isUpdate: UISwitch!
    @IBOutlet var interval: UIStepper!
    
    @IBAction func onSubmit(_ sender: Any) {
        //뷰 컨트롤러에 값 직접 전달 방식
//        //presentingViewController 속성을 통해 이전 화면 객체를 읽어온 다음, ViewController 타입으로 캐스팅 한다.
//        let preVC = self.presentingViewController
//        guard let vc = preVC as? ViewController else {
//            return
//        }
//
//        //값을 전달한다
//        vc.paramEmail = self.email.text
//        vc.paramUpdate = self.isUpdate.isOn
//        vc.paramInterval = self.interval.value
//
//        //이전 화면으로 복귀한다
//        self.presentingViewController?.dismiss(animated: true)
        
        //AppDelegate 이용한 전달 방식
//        //AppDelegate 객체의 인스턴스를 가져온다
//        let ad = UIApplication.shared.delegate as? AppDelegate
//
//        //값을 저장한다.
//        ad?.paramEmail = self.email.text
//        ad?.paramUpdate = self.isUpdate.isOn
//        ad?.paramInterval = self.interval.value
//
//        //이전 화면으로 복귀한다
//        self.presentingViewController?.dismiss(animated: true)
        
        //UserDefault 를 이용한 값 전달
        //UserDefault 객체의 인스턴스를 가져온다
        let ud = UserDefaults.standard
        
        //값을 저장한다
        ud.set(self.email.text, forKey: "email")
        ud.set(self.isUpdate.isOn, forKey: "isUpdate")
        ud.set(self.interval.value, forKey: "interval")
        
        //이전 화면으로 복귀한다
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
}
