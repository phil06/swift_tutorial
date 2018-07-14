* IOS의 화면 전환 방식
특정 상황에 대응할수 있느냐에 따른 차이
    * 소스코드에서 구현하는 방식 : 동적 화면 전환(특정 상황에 대응 가능하지만 복잡하고 어려움)
    * 스토리보드에서 구현하는 방식 : 정적 화면 전환(일괄적으로 적용되서 특정 상황에 대응하기 어렵지만 구현하기 쉬움)

# IOS에서의 화면 전환 개념

* 컨테이너 뷰 컨트롤러(Container View Controller)
컨텐츠를 직접 배치하여 화면을 보여주는 역할 대신 다른 뷰 컨트롤러를 구조화 하는 역할을 한다.

대부분의 화면 전환은 현재화면이 다른 화면으로 완전히 교체되는 것이 아니라 현재 화면이 있는 상태에서 그 위에 새로운 화면이 얹어지는 모양새로 기존화면과 새로운 화면 사이에 서로 참조 관계가 성립된다.

* 화면 전환 특성
    * 다음 화면으로 이동하는 방법과 이전 화면으로 되돌아가는 방법이 다름
    * 화면 전환 방식에 따라 이전 화면으로 되돌아가는 방법이 다름

# 화면 전환 기법1 : 뷰를 이용한 화면전환

# 화면 전환 기법2 : 뷰 컨트롤러 직접 호출에 의한 화면 전환

### 화면전환

이동할 대상 뷰 컨트롤러를 직접 호출해서 화면 표시(=프레젠테이션 방식)

```swift
present(_:animated:)
//present(<새로운 뷰 컨트롤러 인스턴스>, animated:<애니메이션 여부>)

```

화면 전환이 완료되는 시점에 맞추어 특정 로직을 실행해 주어야 할 경우

```swift
present(_:animated:completion:)

```

completion 매개변수는 실행구문을 클로저나 함수 형식으로 입력받아 화면 전환이 완전히 끝난 후에 호출된다.(=화면 전환은 비동기 방식으로 동작함)

프레젠테이션 방식으로 화면을 전환했을때 IOS 시스템은 화면에 표시된 뷰 컨트롤러(presented)와 표시하고 있는 뷰 컨트롤러(presenting)사이에 참조할 수 있는 포인터를 생성하여 서로 참조할 수 있게 해준다. (기존 뷰 컨트롤러인 presentedViewController 속성에다가 자신이 표시하고 있는 새로운 뷰 컨트롤러의 포인터를 저장 / 새로운 뷰 컨트롤러인 presentingViewController 속성에다 자신을 표시한 뷰 컨트롤러의 포인터를 저장함)

### 화면 복귀

이전 화면으로 복귀할 때는 다음과 같은 복귀 메소드를 사용함

```swift
dismiss(animated:)
dismiss(animated:completion:)

```

화면이 사라지게 처리하는 것은 사라질 화면의 뷰 컨트롤러 자신이 아니라 자신을 띄우고 있는 이전 뷰 컨트롤러임.
(복귀 메소드를 호출하는 대상 인스턴스가 바로 self.presentingViewController이다. self 가 아님)

화면을 띄울 때 프레젠트 메소드를 사용했다면, 띄운 화면을 제거할 때는 복귀 메소드를 사용해야 한다.

## 화면 전환 실습

```swift
@IBAction func moveNext(_ sender: Any) {
    let uvc = self.storyboard!.instantiateViewController(withIdentifier: "SecondVC"
    uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
    self.present(uvc, animated: true)
}

```

instantiateViewController()에서 인자값으로 입력된 Storyboard ID와 일치하는 뷰 컨트롤러를 찾아, 인스턴스를 생성하고 값을 받아옴.(인자값으로 입력받은 아이디를 이용하여 스토리보드에서 뷰 컨트롤러를 찾고 연결된 클래스를 읽어와 뷰 컨트롤러에 대한 인스턴스 생성)
클래스의 인스턴스가 생성된다는것 = 객체지향 언어에서 메모리에 올려진다는것

* 여러개의 스토리보드 파일이 존재할 수 있는 상황의 경우

```swift
let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
let uvc = storyboard.instantiateViewController(withIdentifier:"SecondVC")

```

UIStoryboard() 의 첫번째 인자값은 읽어들일 스토리 보드 파일명
UIStoryboard() 의 두번째 인자값은 스토리보드 파일을 읽어들일 위치 (완성된 앱은 성격에 맞는 파일끼리 묶어 여러개의 꾸러미를 만들어내는데, 메인 번들은 앱의 주요 소스 코드 파일을 포함하고 있다.)
* self.storyboard 란?
[Deployment Info] 영역에 Main Interface 항목 (=앱에서 사용할 기본 스토리보드 파일)
옵셔널 타입이므로 nil 검사없이 바로 ! 연산을 사용하여 강제 해제하는것은 좋은 방식이 아님.(옵셔널 체인과 옵셔널 바인딩 구문으로 보강하는것이 좋음)

```swfit
if let uvc = self.storyboard?.~~~~~ //옵셔널 체인
guard let uvc = self.storyboard? ~~~~~~ else { return } //guard 조건문 필터링

```

```swift
uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical

```

* modalTransitionStyle 은 어떤 스타일을 적용해서 전환할 것인지 결정.
4개의 기본 스타일이 제공됨
    * UIModalTransitionStyle.coverVertical : 아래에서 위쪽으로 새로운 화면이 올라가면서 전환되는 효과(default)
    * UIModalTransitionStyle.crossDissolve : 디졸브 상황에서 두 화면이 서로 교차하면서 전 화면이 사라지고 다음 화면이 뚜렷하게 나타나는 전환 효과
    * UIModalTransitionStyle.flipHorizontal : 화면 중앙 가상의 축을 기준으로 화면이 돌아가는 효과(=Flip)를 주면서 새로운 화면으로 전환됨
    * UIModalTransitionStyle.partialCurl : 화면의 오른쪽 아래 모서리에서 시작해 페이지가 말려 올라가는 효과

## 뒤로 가기 버튼 만들기

```swift
@IBAction func back(_ sender: Any) {
    self.presentingViewController?.dismiss(animated: true)
}

```

화면 복귀 시 애니메이션 효과는 전환시 연출되는것의 반대 흐름으로 적용됨.

* 전환할 때 : present(_:animated:) 또는 present(_:animated:completion:)
* 복귀할 때 : dismiss(animated:) 또는 dismiss(animated:completion:)
* Unwind에 대해
IOS앱에서 이전 화면으로 돌아가는것을 말한다.
프레젠테이션 방식으로 화면을 전환할 경우, 뷰 컨트롤러의 포인터는 프레젠테이션 체인에 저장된다. 이전화면으로 되돌아가는 과정은 체인에 저장된 뷰 컨트롤러의 포인터를 제거하는 방식으로 이루어진다.
체인에서 포인터가 제거된 뷰 컨트롤러들은 ARC 시스템에 의해 메모리에서 차례로 해제된다.

# 내비게이션 컨트롤러를 이용한 화면 전환

내비게이션 컨트롤러(Navigation Controller)는 계층적인 성격을 띠는 컨텐츠 구조를 관리하기 위한 컨트롤러.
(컨텐츠 계층 구조의 시작점 역할을 하는 뷰 컨트롤러와 함께 한다. = 루트 뷰 컨트롤러(Root View Controller))
앱의 내비게이션을 표시해줄 수 있는 내비게이션 바(Navigation Bar)가 내장되어 있다.
뷰 컨트롤러들의 전환을 직접 컨트롤 하고, 내비게이션 정보를 표시하는 역할을 한다.
전환이 발생하는 뷰 컨트롤러 들의 포인터를 스택(Navigation Stack = 배열 형식)으로 관리한다.
직접 컨텐츠를 담고 화면을 구성하지는 않는다.

* pushViewController(_:animated:) : 스택의 최상위에 뷰 컨트롤러를 추가할 때 사용
* popViewController(animated:) : 최상위 뷰 컨트롤러를 제거할때 사용
* 낙하산 기능(Embed in) : 현재 스토리보드에서 선택된 객체의 앞쪽, 또는 상위에 객체를 삽입하는 방법
Editor > Embed In > Navigation Controller 메뉴를 통해 네비게이션 컨트롤러를 추가할 수 있다.

내장된 내비게이션 바에 내비게이션 아이템(Navigation Item) 객체를 추가하여 타이틀을 작성할 수 있고,(타이틀이 아이템 위에서만 동작한다) 버튼(Bar Button Item)을 추가 할 수 있다.
일반 버튼도 네비게이션 바에 추가할 수 있지만 자동으로 Bar Button Item으로 변환된다.
추가 가능한 영역은 왼쪽 / 오른쪽 / 중앙 이나, 왼쪽은 자동으로 뒤로가기 기능을 직접 구현하기 때문에 커스텀으로 생성해버리면 자동기능을 사용할 수 없고 뒤로가기 기능을 직접 구현해야 한다

> present(_:animated:) 메소드가 뷰 컨트롤러 자신을 대상으로 호출하는것이었다면,_
> _pushViewController(_:)메소드는 호출하는 대상이 내비게이션 컨트롤러 이다.

내비게이션 컨트롤러는 직접 연결된 루트 뷰 컨트롤러 뿐만 아니라 내비게이션 컨트롤러가 제어하는 모든 뷰 컨트롤러의 상단에 내비게이션 바를 삽입하여 자신의 존재를 알게 한다.
각 뷰 컨트롤러 마다 내장된 내비게이션 바에 이전 화면으로 되돌아갈 수 있는 버튼을 자동으로 만들어 준다.

동일한 뷰 컨트롤러 라도 화면 전환 방식에 따라 상태가 달라져서 내비게이션 컨트롤러의 제어하에 놓이기도 하고 그렇지 않기도 하다.

``` swift
_ = self.navigationController?.popViewController(animated: true)

```

> 스위프트 언어에서 언더바(_)는 대부분 같은 의미로 사용됨. "값을 대입할 변수가 필요한 것은 알고있지만 필요하지 않으니 굳이 변수에 할당하지 마라"

# 세그웨이를 이용한 화면 전환

세그웨이 란 ?

> 스토리 보드에서 뷰 컨트롤러 사이의 연결 관계 및 화면전환을 관리하는 역할(한쪽으로만 통행 할 수있으니 일방통행 다리(One-Way Bridge)라고 할 수 있겠다)
> 뷰 컨트롤러 사이에 연결된 화살표로 표시됨
> 대상 뷰 컨트롤러의 인스턴스를 자동으로 만들어 줌(스토리보드를 통해 세그웨이의 출발지/목적지 뷰 컨트롤러에 대한 인스턴스가 생성되고 포인터가 세그웨이 객체에 설정된다.)

* 메뉴얼 세그웨이(Manual Segue) : 출발점이 뷰 컨트롤러 자체인 경우(UIKit 프레임워크에 정의된 performSegue() 메소드를 사용함)
* 액션 세그웨이(Action Segue) / 트리거 세그웨이(Trigger Segue) : 버튼 등이 출발점인 경우

## 액션 세그웨이

트리거와 세그웨이가 직접 연결된 것.
연결 옵션 중 "Present Modally" 항목은 `present(_:animated:)` 메소드를 이용한 화면 전환과 같은 기능을 함.

> 내비게이션 컨트롤러가 없을 때는 세그웨이를 "show" 타입으로 생성했어도 "Present Modally" 방식으로 실행된다.

## 메뉴얼 세그웨이

```swift
performSegue(withIdentifier : <세그웨이 식별자>, sender : <세그웨이 실행 객체>)

```

세그웨이가 여러 개일 경우를 대비해 세그웨이 식별자와 실행하는 객체 정보를 함께 받는다.
어트리뷰트 인스펙터 탭 > Identifier 항목값을 식별자로 인식함.

### 연결방법

뷰 컨트롤러 상단에 도크바(Dock Bar)가 있는데 "View Controller" 툴팁이 표시되는 첫번째 아이콘을 클릭한 상태(with Ctrl) 로 전환하고자 하는 뷰 컨트롤러로 드래그 한다.

### 화면 전환 효과

어트리뷰트 인스펙터 탭 > Storyboard Segue > Transition 항목에서 효과 변경.

## Unwind - 화면 복귀

예외적인 상황을 제외하고 IOS에서 뷰 컨트롤러의 인스턴스는 싱글톤 패턴이어야 한다.

도크바의 아이콘중 세번째 아이콘에 마우스를 올려보면 "Exit" 라는 툴팁이 표시되는데, 이것을 이용하여 현재화면을 종료하고 이전화면으로 되돌아가는 Unwind Segue 를 구현 할 수 있다.

### Unwind Segueway 구현방법

```swift
@IBAction func unwindToVC(_ segue: UIStoryboardSegue) {
    //호출시 매개변수명을 생략 할 수 있도록 언더바(_)를 이용하여 익명처리 한다.
}

```

1. A에 UIStoryboardSegue 타입의 인자를 받는 @IBAction 메소드를 정의
2. B에 버튼을 만들고 "Exit" 아이콘에 드래그
3. A에 생성된 메소드가 인식되어 선택해주면 자동으로 연결됨

코코아 터치 시스템은 앱 내부에 정의된 모든 메소드를 스캔하여, 이중에서 UIStoryboard 타입의 인자값을 입력받는 액션 메소드를 모두 수집한다.(현재 화면을 종료했을 때 어느 화면으로 이동할지 여부를 알기 위한 이정표 역할)

> 중간 페이지(화면)로 복귀하고자 하는 경우 복귀하고싶은 화면에 UIStoryboardSegue 객체를 인자로 받는 메소드를 구현해두면 Unwind 메소드로 인식하여 액션만 연결해주면 된다.

## 커스텀 세그웨이

커스텀 세그웨이는 UIStoryboardSegue 클래스를 상속받는 클래스를 작성해야 한다.
커스텀 세그웨이에서도 원하는 화면전환 기능을 구현하기 위해서는 perform() 메소드를 오버라이드 해야 한다.
스토리보드 인터페이스에 연결할때 Action Segue > Custom 으로 선택해야 한후, 세그웨이를 선택하여 어트리뷰트 인스펙터 탭에서 Storyboard Segue > Class 항목을 선택해줘야 함.

``` swift
class NewSegue: UIStoryboardSegue {
// 컨트롤러 전체를 전환하는 대신, 다른 컨트롤러에 있는 뷰만 읽어와 전환하는 세그웨이
    override func perform() {
        let srcUVC = self.source
        let destUVC = self.destination
        //UIView 객체의 전환 기능
        UIView.transition(from: srcUVC.view,    //출발지 뷰
                                        to: destUVC.view,   //목적지 뷰
                                        duration: 2,    //<화면 전환에 소요되는 시간(단위:초)>
                                        options: ,transitionCurlDown
                                        completion: <화면 전환이 끝난 후 실행할 함수나 클로저>)
    }
}

```

## 전처리 메소드의 활용

코코아 터치 프레임워크는 세그웨이가 실행되기 전에 특정한 메소드를 호출하도록 설계되어 있다. (=전처리 메소드(Pre-Process Method))
화면 전환 전에 필요한 처리가 가능하다.
호출 주체는 사용자가 아닌 시스템이다.
UIViewController 에 정의되어 있는거다.

> prepare(for segue: UIStoryboardSegue, sender: Any?) { ... }
> segue : 메소드를 호출한 세그웨이 객체
> sender : 세그웨이를 실행하는 트리거에 대한 정보

### 여러개의 세그웨이가 있을때 식별하는 방법

세그웨이를 선택하고 어트리뷰트 인스펙터 탭 > Identifier 항목의 값을 식별자로 지정

> segue.identifier! 로 식별자를 얻어올 수 있다.