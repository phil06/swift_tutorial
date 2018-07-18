//
//  ListViewController.swift
//  TUTORIAL_08
//
//  Created by saera on 2018. 7. 17..
//  Copyright © 2018년 OnlyNew. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
    var dataset = [
    ("다크 나이트", "영웅물에 철학에 음악까지 더해져 예술이 되다", "2008-09-04", 8.95, "darknight.jpg"),
    ("호우시절", "때를 알고 내리는 좋은 비", "2009-10-08", 7.31, "rain.jpg"),
    ("말할 수 없는 비밀", "여기서 너까지 다섯 걸음", "2015-05-07", 9.19, "secret.jpg")
    ]
    
    //테이블 뷰를 구성할 리스트 데이터
//    var list = [MovieVO]()

    //클로저를 이용한 프로퍼티 초기화
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        for(title, desc, opendate, rating, thumbnail) in self.dataset {
            let mvo = MovieVO()
            mvo.title = title
            mvo.description = desc
            mvo.opendate = opendate
            mvo.rating = rating
            mvo.thumbnail = thumbnail
            datalist.append(mvo)
        }
        return datalist
    }()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //주어진 행에 맞는 데이터 소스를 읽어온다
        let row = self.list[indexPath.row]
        
        //테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        
        //프로토타입 셀이 제공하는 라벨 사용했을때
//        cell.textLabel?.text = row.title
//        cell.detailTextLabel?.text = row.description
        
        //커스텀 셀로 라벨들을 직접 구현했을때
//        let title = cell.viewWithTag(101) as? UILabel
//        let desc = cell.viewWithTag(102) as? UILabel
//        let opendate = cell.viewWithTag(103) as? UILabel
//        let rating = cell.viewWithTag(104) as? UILabel
//        title?.text = row.title
//        desc?.text = row.description
//        opendate?.text = row.opendate
//        rating?.text = "\(row.rating!)"
        
        //프로토 타입 셀을 커스텀 스타일로 바꾸고 커스텀 클래스를 사용했을때
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        cell.thumbnail.image = UIImage(named: row.thumbnail!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row)번째 행입니다.")
    }
    
    override func viewDidLoad() {
//        //첫번째 행
//        var mvo = MovieVO()
//        mvo.title = "다크나이트"
//        mvo.description = "영웅물에 철학에 음악까지 더해져 예술이 되다."
//        mvo.opendate = "2008-09-04"
//        mvo.rating = 8.95
//        //배열에 추가
//        self.list.append(mvo)
//
//        //두번째 행
//        mvo = MovieVO()
//        mvo.title = "호우시절"
//        mvo.description = "때를 알고 내리는 좋은 비"
//        mvo.opendate = "2009-10-08"
//        mvo.rating = 7.31
//        //배열에 추가
//        self.list.append(mvo)
//
//        //세번째 행
//        mvo = MovieVO()
//        mvo.title = "말할 수 없는 비밀"
//        mvo.description = "여기서 너까지 다섯 걸음"
//        mvo.opendate = "2015-05-07"
//        mvo.rating = 9.19
//        //배열에 추가
//        self.list.append(mvo)
    }
}
