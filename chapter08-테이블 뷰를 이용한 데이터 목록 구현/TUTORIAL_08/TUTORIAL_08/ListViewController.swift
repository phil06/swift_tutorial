//
//  ListViewController.swift
//  TUTORIAL_08
//
//  Created by saera on 2018. 7. 17..
//  Copyright © 2018년 OnlyNew. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
//    var dataset = [
//    ("다크 나이트", "영웅물에 철학에 음악까지 더해져 예술이 되다", "2008-09-04", 8.95, "darknight.jpg"),
//    ("호우시절", "때를 알고 내리는 좋은 비", "2009-10-08", 7.31, "rain.jpg"),
//    ("말할 수 없는 비밀", "여기서 너까지 다섯 걸음", "2015-05-07", 9.19, "secret.jpg")
//    ]
    
    //테이블 뷰를 구성할 리스트 데이터
    var list = [MovieVO]()

    //클로저를 이용한 프로퍼티 초기화
//    lazy var list: [MovieVO] = {
//        var datalist = [MovieVO]()
//        for(title, desc, opendate, rating, thumbnail) in self.dataset {
//            let mvo = MovieVO()
//            mvo.title = title
//            mvo.description = desc
//            mvo.opendate = opendate
//            mvo.rating = rating
//            mvo.thumbnail = thumbnail
//            datalist.append(mvo)
//        }
//        return datalist
//    }()
    
    //현재까지 읽어온 데이터의 페이지 정보
    var page = 1
    
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
//        cell.thumbnail.image = UIImage(named: row.thumbnail!)
        //썸네일 경로를 인자값으로 하는 URL 객체 생성
        let url: URL! = URL(string: row.thumbnail!)
        //이미지를 읽어와 Data 객체에 저장
        let imageData = try! Data(contentsOf: url)
        //UIImage 객체를 생성하여 아울렛 변수의 image 속성에 대입
        cell.thumbnail.image = UIImage(data: imageData)
        
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
        
        callMovieAPI(page:1)
    }
    
    @IBOutlet var moreBtn: UIButton!
    
    
    @IBAction func more(_ sender: Any) {
        //현재 페이지 값에 1을 추가한다
        self.page += 1
        callMovieAPI(page: self.page)
        self.tableView.reloadData()
    }
    
    func callMovieAPI(page: Int) {
        //1.호핀 API호출을 위한 URI를 생성
        let url =  "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(page)&count=10&genreId=&order=releasedateasc"
        let apiURI: URL! = URL(string: url)
        //2.REST API호출
        let apidata = try! Data(contentsOf: apiURI)
        //3.데이터 전송 결과를 로그로 출력(반드시 필요한 코드는 아님)
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result=\( log )")
        //JSON객체를 파싱하여 NSDictionary 객체로 받음
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            //데이터 구조에 따라 차례대로 캐스팅하며 읽어온다
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            //Iterator처리를 하면서 API데이터를 MovieVO 객체에 저장한다
            for row in movie {
                //순회 상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary
                //테이블 뷰 리스트를 구성할 데이터 형식
                let mvo = MovieVO()
                //movie 배열의 각 데이터를 mvo 상수의 속성에 대입
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                //list배열에 추가
                self.list.append(mvo)
            }
            
            let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue
            //totalCount가 읽어온 데이터 크기와 같거나 클 경우 더보기 버튼을 막는다
            if(self.list.count >= totalCount) {
                self.moreBtn.isHidden = true
            }
            
            self.tableView.reloadData()
        } catch {
            
        }
    }
    
}
