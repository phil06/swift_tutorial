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
        
        NSLog("제목:\(row.title!), 호출된 행번호:\(indexPath.row)")
        
        //프로토 타입 셀을 커스텀 스타일로 바꾸고 커스텀 클래스를 사용했을때
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        
        //비동기 방식으로 섬네일 이미지를 읽어옴
        DispatchQueue.main.async(execute: {
            cell.thumbnail.image = self.getThumbnailImage(indexPath.row)
        })
        
        //이미지 객체를 대입한다
//        cell.thumbnail.image = row.thumbnailImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row)번째 행입니다.")
    }
    
    override func viewDidLoad() {
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
        let url =  "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(page)&count=30&genreId=&order=releasedateasc"
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
                
                //웹상에 있는 이미지를 읽어와 UIImage 객체로 생성
                let url: URL! = URL(string: mvo.thumbnail!)
                let imageData = try! Data(contentsOf: url)
                mvo.thumbnailImage = UIImage(data: imageData)
                
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
    
    func getThumbnailImage(_ index: Int) -> UIImage {
        //인자값으로 받은 인덱스를 기반으로 해당하는 배열 데이터를 읽어옴
        let mvo = self.list[index]
        
        //메모제이션 : 저장된 이미지가 있으면 그것을 반환하고, 없을 경우 내려받아 저장한 후 반환
        if let savedImage = mvo.thumbnailImage {
            return savedImage
        } else {
            let url: URL! = URL(string: mvo.thumbnail!)
            let imageData = try! Data(contentsOf: url)
            mvo.thumbnailImage = UIImage(data: imageData) //UIImage를 MovieVO 객체에 우선저장
            
            return mvo.thumbnailImage! //저장된 이미지를 반환
        }
    }
    
}

extension ListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //실행된 세그웨이의 식별자가 "segue_detail"이라면
        if segue.identifier == "segue_detail" {
            //사용자가 클릭한 행을 찾아낸다
            let path = self.tableView.indexPath(for: sender as! MovieCell)
            
            //행 저보를 통해 선택된 영화 데이터를 찾은 다음, 목적지 뷰 컨트롤러의 mvo 변수에 대입한다.
            let detailVC = segue.destination as? DetailViewController
            detailVC?.mvo = self.list[path!.row]
        }
    }
}


















