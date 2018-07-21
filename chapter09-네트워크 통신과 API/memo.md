# 네트워크 통신의 종류

## 소켓 방식의 연결 지향 통신

## 비연결 지향 통신

스위프트에서는 파이썬과 유사한 딕셔너리(Dictionary) 자료형이 제공됨. 스위프트에서 딕셔너리는 동일한 타입의 데이터만 저장할 수 있다는 제약이 따르므로 딕셔너리와 유사한(다양한 형태의 데이터 타입을 허용하는) NSDictionary, NSMutableDictionary 가 있음.

* NSDictionary : 한번 데이터가 정의되고 나면 새로운 데이터를 추가하거나 수정/삭제 할 수 없다
* NSMutableDictionary : 저장된 데이터를 얼마든지 수정/삭제할 수 있다.


# 오픈 API와 공공 콘텐츠

## 오픈 API

## 영화 정보 제공 서비스

# 오픈 API를 이용한 네트워크 실습

## API 기본 정보

## 네트워크 객체를 통한 데이터 요청 기능 구현

```
var list = Data(contentsOf: URL타입의 객체)
```

Data는 파운데이션 프레임워크에서 제공하는 클래스. 바이너리 데이터도 담을 수 있어, 여러가지 종류의 데이터를 처리하는데에 탁월함. NSData라는 같은기능을 하는 객체를 원본으로 삼으며 서로 타입 캐스팅도 가능하다. (응답을 받지 못하는 등의 경우도 있을 수 있어서 Data(ContentsOf:)를 통해 생성되는 인스턴스는 항상 옵셔널 타입이 됨)

```
NSString(data:<문자열로 변환할 Data타입 객체>, encoding:<인코딩 형식>
```

Data 타입의 객체를 입력받아 원하는 인코딩 타입의 문자열로 반환하는 역할. 파운데이션 프레임워크에서 제공하는 NSString은 입력받은 Data객체를 문자열로 변환하는 메소드를 지원하지만 스위프트의 기본 자료형인 String은 직접변환 메소드가 없다. 서로 호환되고 문자열을 다룬다는 공통점이 있지만, NSString은 프레임워크 수준에서 정의된 클래스이고 String은 언어 수준에서 정의된 구조체이다.

## 전달받은 데이터를 파싱하여 화면에 출력

JSON 데이터를 파싱할때는 파운데이션 프레임워크에서 제공하는 JSONSerialization객체의 jsonObject() 메소드를 사용하는 것이 좋으며 오류가 발생하면 예외를 던지므로 do~try~catch 구문으로 감싸주어야 한다.

```
//앱의 로컬 경로에 있는 이미지 로드
cell.thumbnail.image = UIImage(name:row.thumbnail!)

//웹상에 있는 이미지 로드
//썸네일 경로를 인자값으로 하는 URL 객체 생성
let url: URL! = URL(string: row.thumbnail!)
//이미지를 읽어와 Data 객체에 저장
let imageData = try! Data(contentsOf: url)
//UIImage 객체를 생성하여 아울렛 변수의 image 속성에 대입
cell.thumbnail.image = UIImage(data: imageData)
```

웹상에 있는 경로에서 데이터를 읽어오는 Data(contentsOf:)초기와 메소드를 이용하여 api 호출 뿐만이 아닌 웹을 통해 접근 가능한 모든 데이터를 읽어올 수 있다.(이미지의 경우 데이터로 읽어온 후 UIImage 객체로 생성가능)

## 더보기 기능 구현

