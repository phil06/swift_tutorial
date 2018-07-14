//
//  ViewController.swift
//  TUTORIAL_06
//
//  Created by saera on 2018. 7. 12..
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

    @IBOutlet var result: UILabel!
    
    @IBAction func alert(_ sender: Any) {
        let alert = UIAlertController(title: "선택", message: "항목을 선택해주세요", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { (_) in
            self.result.text = "취소 버튼을 클릭했습니다."
        }
        let confirm = UIAlertAction(title: "확인", style: .default) { (_) in
            self.result.text = "확인 버튼을 클릭했습니다"
        }
        let execute = UIAlertAction(title: "실행", style: .destructive) {(_) in
            self.result.text = "실행 버튼을 클릭했습니다"
        }
        let stop = UIAlertAction(title: "중지", style: .default) { (_) in
            self.result.text = "중지 버튼을 클릭했습니다"
        }
        
        //버튼을 컨트롤러에 등록
        alert.addAction(cancel)
        alert.addAction(confirm)
        alert.addAction(execute)
        alert.addAction(stop)
        
        //메시지 창 실행(뷰 노출하는거랑 같음)
        self.present(alert, animated: false)
    }
    
    @IBAction func login(_ sender: Any) {
        let title = "iTunes Store에 로그인"
        let message = "사용자의 Apple ID oobtloo@naver.com의 암호를 입력하십시오"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default, handler: {(_) in
            //확인 버튼을 클릭했을때 처리할 내용
            if let tf = alert.textFields?[0] {
                print("입력된 값은 \(tf.text!)입니다.")
            } else {
                print("입력된 값이 없습니다")
            }
        })
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        //텍스트 필드 추가
        alert.addTextField(configurationHandler: { (tf) in
            //텍스트 필드의 속성 설정
            tf.placeholder = "암호" //안내 메세지
            tf.isSecureTextEntry = true //비밀번호 처리
        })
        
        self.present(alert, animated: false)
    }
    
    @IBAction func auth(_ sender: Any) {
        //메시지 창 관련 객체 정의
        let msg = "로그인"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default, handler: { (_) in
            //확인 버튼을 클릭했을 때 실행할 내용
            let loginId = alert.textFields?[0].text
            let loginPw = alert.textFields?[1].text
            
            if loginId == "sqlpro" && loginPw == "1234" {
                self.result.text = "인증되었습니다"
            } else {
                self.result.text = "인증에 실패하였습니다"
            }
        })
        
        //정의된 액션 버튼 객체를 메시지창에 추가
        alert.addAction(cancel)
        alert.addAction(ok)
        
        //아이디 필드 추가
        alert.addTextField(configurationHandler: { (tf) in
            tf.placeholder = "아이디"
            tf.isSecureTextEntry = false
        })
        
        //비밀번호 필드 추가
        alert.addTextField(configurationHandler: { (tf) in
            tf.placeholder = "비밀번호"
            tf.isSecureTextEntry = true
        })
        
        self.present(alert, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //메시지 창을 처리하기 적절한 위치
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //메시지 창을 처리하기 부적절한 위치(아직 뷰가 화면에 구현되기 전임)
    }
    
}

