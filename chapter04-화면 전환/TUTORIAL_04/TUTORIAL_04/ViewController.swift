//
//  ViewController.swift
//  TUTORIAL_04
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

    @IBAction func moveNext(_ sender: Any) {
        //이동할 뷰 컨트롤러 객체를 스토리보드ID 정보를 이용하여 참조
        let uvc = self.storyboard!.instantiateViewController(withIdentifier: "SecondVC")
        
        //화면 전환할 때의 애니메이션 타입
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        //인자값으로 뷰 컨트롤러 인스턴스를 넣고 프레젠트 메소드 호출
        self.present(uvc, animated: true)
    }
    
    @IBAction func moveNext2(_ sender: Any) {
        if let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") {
            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            self.present(uvc, animated: true)
        }
    }
    
    @IBAction func moveNext3(_ sender: Any) {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return
        }
        
        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(uvc, animated: true)
    }
    
}

