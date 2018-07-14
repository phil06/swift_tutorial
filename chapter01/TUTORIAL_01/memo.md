`뷰 컨트롤러(View Controller)`는 하위에 있는 콘텐츠를 관리하고 보여주거나 숨기는 등의 구성을 조정하는 역할. 내부적으로 뷰를 포함하고 있으며, 뷰에 대한 관리를 주로 하며 화면 전환이 발생할 때 다른 뷰 컨트롤러와 서로 통신하고 조정하는 일을 수행한다.

[참고1] UIKit 프레임워크와 화면 구성요소의 관계



뷰 컨트롤러는 화면을 그려내는 데에 반드시 필요한 요소는 아니다.
앱 아키텍쳐에서 MVC패턴을 도입하면서 생겨나게 된 단순한 컨트롤러 객체라고 볼 수 있음. 뷰 컨트롤러가 뷰와의 리소스를 관리하는 역할을 해서 그 역할에 대한 내용이 UIViewController에 정의되어있다보니 모든 뷰 컨트롤러가 UIViewController 를 상속받아야 한다.

# 첫번째 앱, Hello World!

## Xcode 프로젝트 생성

* ProductName
프로젝트의 이름은 앱의 고유 식별 코드인 `Bundle Identifier(번들 아이디)`를 만드는 요소로 사용된다.
* Organization Identifier
Product Name 항목과 연결되어 Bundle Identifier 항목을 완성한다.(대체로 도메인에서 www를 뺀 나머지를 역순으로 많이 사용함)

## 프로젝트 설정

* Info > Identify
`Bundle Name` 과 `Display Name` 항목의 값이 동시에 설정될 경우 Xcode는 Display Name 을 우선 적용한다.
* Deployment Target
배포를 허용할 IOS버전의 하한선을 지정하는 항목
* Main Interface
앱이 처음 실행될 때 기본 인터페이스 파일을 정함

## 프로젝트 구성과 스토리보드

AppDelegate.swift 는 앱 전체의 생명주기 관리를 위임받은 객체인 앱 델리게이트를 구현한 클래스.
스토리보드는 화면사이의 전환 (called Segueway:세그웨이)을 손쉽게 처리 가능

## 스토리보드로 화면 구성하기

## 화면 전환 구현하기

## 스위프트 코드 작성하기

```swift
class ViewController: UIViewController { ... }

```

UIViewController 클래스는 UIKit 프레임워크에 정의되어있는 클래스로서, 뷰 컨트롤러를 정의하려면 반드시 이 클래스를 상속받거나 상속받은 다른 클래스를 상속받아야 한다.

```swift
override func viewDidLoad() {
   super.viewDidLoad()
}

```

viewDidLoad()는 부모 클래스인 UIViewController 클래스에 정의되어있는 메소드로, 뷰의 로딩이 완료되었을 때 시스템에 의해 자동으로 호출된다.

```swift
override func didReceiveMemoryWarning() {
   super.didReceiveMemoryWarning()
}

```

didReceiveMemoryWarning() 메소드는 메모리가 부족할 때 시스템에서 자동으로 호출하는 메소드.
IOS는 가상 메모리나 스왑 메모리를 가지지 않으므로 메모리 부족 경고가 발생할 경우 메모리 확보를 위해 필요없는 객체의 메모리를 해제해서 재사용 가능하도록 만들어주는 처리가 반드시 필요함.

재정의된 메소드는 적절한 시점에서 시스템에 의해 자동으로 호출되는 콜백메소드(Callback Method)이기 때문에 필요할 때만 사용하자.

```swift
@IBOutlet var uiTitleL UILabel!

```

인터페이스 빌더의 레이블을 스위프트 클래스가 참조할 수 있도록 연결된 멤버 변수로, `아울렛 변수` 라고도 부른다. @IBOutlet 이라는 키워드는 인터페이스 빌더에 관련된 속성이라는 것을 알려주는 어노테이션.

# 시작 화면 제어하기

## 시작 화면 편집

`application(_:didFinishLaunchingWithOptionsL:)` 메소드는 앱이 처음 실행될때 필요한 시스템적 처리를 모두 끝내고 메인 화면을 표시하기 직전에 호출된다.
(=스크린에 표시된 후 해당 메소드가 호출되고 메소드 내부에 작성된 내용이 모두 실행되면 스토리보드의 화면이 스크린에 표시됨)

## 새로운 시작 화면 파일로 교체하기
