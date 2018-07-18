//
//  ListViewController.swift
//  TUTORIAL_08_2
//
//  Created by saera on 2018. 7. 18..
//  Copyright © 2018년 OnlyNew. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    //테이블 뷰에 연결될 데이터를 저장하는 배열
    var list = [String]()
    
    @IBAction func add(_ sender: Any) {
        //알림창 객체의 인스턴스를 생성한다
        let alert = UIAlertController(title: "목록 입력", message: "추가될 글을 작성해주세요", preferredStyle: .alert)
        //알림창에 입력폼을 추가한다
        alert.addTextField { (tf) in
            tf.placeholder = "내용을 입력하세요"
        }
        //OK버튼 객체를 생성한다:아직 알림창 객체에 버튼이 등록되지 않은 상태
        let ok = UIAlertAction(title: "OK", style: .default) { (_) in
            //알림창의 0번째 입력필드에 값이 있다면
            if let title = alert.textFields?[0].text {
                //배열에 입력된 값을 추가하고 테이블을 갱신
                self.list.append(title)
                self.tableView.reloadData()
            }
        }
        //취소 버튼 객체를 생성한다:아직 알림창 객체에 버튼이 등록되지 않은 상태
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler:nil)
        //알림창 객체에 버튼 객체를 등록한다
        alert.addAction(ok)
        alert.addAction(cancel)
        //알림창을 띄운다
        self.present(alert, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //"cell"아이디를 가진 셀을 읽어온다. 없으면 UITableViewCell 인스턴스를 생성한다
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        //셀의 기본 텍스트 레이블에 배열 변수의 값을 할당한다
        cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let row = self.list[indexPath.row]
//        //높이를 조절해준다. 기본 높이 60 + 길이가 30자를 넘어갈 때마다 20만큼씩 높이를 늘려준다.
//        let height = CGFloat(60 + (row.count / 30) * 20)
//        return height
//    }
    
}
