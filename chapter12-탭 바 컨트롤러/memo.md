# 탭 바 컨트롤러

탭 바 컨트롤러(Tab Bar Controller) : 수평적 관계의 독립된 각 화면에 바로 접근할 수 있도록 탭 바를 제공하는 컨트롤러. 독립된 하나의 화면과 콘텐츠를 가지지 않는 대신 각각의 화면과 연결된 탭 바를 화면 하단에 나열하여 다른 뷰 컨트롤러를 제어함.

컨테이너 컨트롤러(Container Controller) : 직접 컨텐츠를 표현하지 않으면서 다른 뷰 컨트롤러를 유기적인 관계로 제어하는 역할을 하는 컨트롤러. (내비게이션 컨트롤러, 분할 뷰 컨트롤러, 페이지 뷰 컨트롤러 등)

## 탭 바의 기본 개념

탭 바 컨트롤러는 각각의 탭마다 자신의 루트 뷰 컨트롤러와 직접 연결된다. 오브젝트 라이브러리를 통해 탭 바 컨트롤러를 추가하면 탭 바에 연결된 두 개의 뷰 컨트롤러가 함께 추가됨.

## 탭 바에 새 탭 추가하기

> 탭 바에 새 탭을 추가하는 과정

    1. 탭 바에 연결할 뷰 컨트롤러를 스토리보드에 추가
    2. 탭 바 컨트롤러에서 Ctrl + 드래그 하여 추가된 뷰 컨트롤러를 연결
    3. 표시된 팝업 창에서 [Relationship Segue] 항목 아래 view controllers 선택 

## 탭 바의 주요 기능

탭 바 컨트롤러와 뷰 컨트롤러 사이의 연결 역시 세그웨이의 일종이라고 할수 있다(=관계형 세그웨이[Relationship Segue]) 화면의 이동 대신 특정 타입의 컨트롤러가 다른 뷰 컨트롤러를 품을 수 있도록 연결해주는 일종의 고리.

> 탭바 순서 변경 : 바꾸려는 탭을 드래그 하여 원하는 탭 위치에 놓는다

> 아이콘 : 개별 탭은 탭 바에 구현되는 것이 아니라 각각의 뷰 컨트롤러에 구현된다. 탭 바는 이 정보를 모아 배열하고 한꺼번에 보여주는 역할 이상은 하지 않음.

> 배지 : 배지를 동적으로 표시하고자 할 때는 tabBarItem 객체 아래 badgeValue라는 문자열 타입의 속성을 이용한다.

> More 탭 : 공간 제약상 세로화면에서 최대 5개까지 표현할 수 있고 초과하면 4개표시 후 `More`라는 탭이 자동으로 추가된다.

# 탭 바를 이용한 영화관 정보 제공

## 탭 바 컨트롤러 구성

탭바에 들어가는 이미지는 맞춰서 리사이징(Re-Sizig) 되지 않아서 기본크기인 30x30으로 만들어야 한다. 단 이름뒤에 @2x와 같이 해상도를 인식할 수 있게 해주면 60x60, 90x90 으로 만들어도 상관없다.

## 영화관 정보 API

```swift
let stringdata = try NSString(contentsOf: urlObj!, encoding: 0x80_000_422)
//0x80_000_422는 EUC-KR 인코딩에 해당하는 16진수 값이다.
//언더바는 자리수를 가독성 좋게 나눈것으로, 쉼표대신 넣을 수 있는 표기용 언더바는 원래의 값에 아무런 영향을 주지 않는다.
```

# 영화관 목록 화면 구현하기
