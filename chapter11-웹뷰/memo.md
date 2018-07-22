애플은 다양한 방식으로 웹 브라우저를 구현할 수 있도록 지원한다.

    1.사파리 앱 호출

    2.UIWebView 구현

    3.WKWebView 구현

    4.SFSafariViewController 구현 

        사파리 앱을 거의 그대로 지원하되, 앱 내부에 넣어 사용할 수 있도록 컨트롤러 객체 형태로 구현되어 있다.

> 웹뷰(Web View)는? 웹페이지를 탐색하기 위해 사용하는 뷰(View) 객체로, 앱 안에 심을 수 있는 일종의 내장형 웹 브라우저 (인앱 브라우저(In-App Browser)라고도 함). 단순히 URL을 호출하여 웹 페이지를 보여주는 기본 기능 정도만 제공한다.

## 사파리 앱 호출하기

```swift
let url = URL(string:"https://www.google.com")
UIApplication.shared.open(url!, options: [:])
```

네트워크 통신 자체를 사파리 앱이 대신 처리하기 때문에 info.plist 파일에 App Transport Security설정을 해줄 필요가 없다. (ATS설정은 앱 내부에서 URLSession, URLRequest 관련 객체를 쓸 때에만 필요함)

## UIWebView 객체 사용하기

```swift
@IBOutlet var webView: UIWebView!

let url = URL(string:"https://www.google.com")
let req = URLRequest(url: url!)

self.webView.loadRequest(req)
```

이 방식은 ATS 설정이 필요하다.

## WKWebView 객체 사용하기

UIWebView의 사용법과 거의 동일하다. `WebKit`이라는 별도의 프레임워크를 통해 제공되므로 `import WebKit` 구문이 필요하다.

## SFSafariViewController 실행하기

```swift
import SafariServices

let url = URL(string: "https://www.google.com")
let safariViewController = SFSafariViewController(url: url)

present(safariViewController, animated: true, completion: nil)
```

컨트롤러 객체에 해당된다. UI에 삽입하는 것이 아니라 단순히 코드를 호출하면 된다. 사파리 서비스(Safari Service)프레임워크를 통해 제공되므로 import 가 필요하며, 특정 메소드를 호출하는것이 아닌 화면을 전환하는 방식으로 컨트롤러를 호출해야 한다. (URL 객체를 컨트롤러 초기화 시에 인자값으로 넣어주면 됨))

# WKWebView를 이용하여 영화 정보 상세 화면 구현하기

내비게이션 바는 실제 위치와 공간을 베타적으로 점유하는 객체가 아니라, 기존 객체의 위에 겹쳐지는 레이어 형태. WKWebView 객체는 WebKit 프레임워크에 속해 있음.

> tableView의 indexPath(for:) 메소드 : 인자값으로 전달된 셀 객체가 테이블 뷰에서 몇번째 행에 해당하는지에 대한 정보를 IndexPath 객체 형태로 반환한다.

```swift
let detailVC = segue.destination as? DetailViewController
```

segue.destination은 세그웨이의 목적지에 해당하는 뷰 컨트롤러 객체를 참조하는 속성 (세그웨이는 우리가 임의로 뷰 컨트롤러의 인스턴스를 직접 생성했더라도 사용하지 않고 스스로 생성함). 주의할점은 가져온 인스턴스의 타입이 UIViewController이기 때문에 필요에 따라 타입 캐스팅이 필요함

> 네비게이션 바의 타이틀 제어는 self.navigationItem.title 속성을 이용

```swift
if let url = self.mvo?.detail {
    ...
} else {
    ...
}
//if 조건절 내부에서 옵셔널 값을 변수나 상수에 바인딩 하면 성공 여부에 따라 true나 false가 반환됨.
//바인딩 후에는 옵셔널이 자동으로 해제되므로 ?나 !등 옵셔널 처리를 위한 연산자 없이 바로 사용가능.
```

# WKWebView

* load(_:) 메소드

    요청된 정보를 바탕으로 HTML파일을 읽어들이는 메소드. 인자값으로 URLRequest 객체를 입력받는다. 앱 내부에 저장된 로컬 HTML을 읽어들이고자 한다면 loadHTMLString(:baseURL:) 메소드를 사용해야 한다. 비동기 메소드여서 블로킹(Blocking)현상이 발생하지 않는다.

* stopLoading() 메소드

    웹페이지 로딩 도중에 중단하고자 할때 사용

* isLoading 프로퍼티

    웹 페이지의 로딩 진행 여부 체크 가능.

* goBack(), goForward() 메소드

WKWebView는 델리게이트 패턴을 통해 웹페이지의 로딩 상황을 추적하고, 콘텐츠나 사용자의 액션을 제어할 수 있도록 지원합니다. 필요한 메소드들은 WKNavigationDelegate 프로토콜과 WKUIDelegate에 나뉘어 정의되어 있다.

WKNavigationDelegate 프로토콜은 주로 웹킷 뷰의 로딩 상황을 추적하거나 제어하는데에 필요한 내용을 담고 있다.

1. webView(_:decidePolicyFor:decisionHandler:)

    웹 페이지를 읽어올지 말지를 결정하는 메소드. 웹뷰 내에서 허용하고 싶지 않은 요청이나 URL을 선택적으로 차단 할 수 있다.

    ```swift
    //웹 페이지의 로딩을 명시적으로 허용하고자 할 때에는 .cancel 대신 .allow를 사용
    decisionHandler(.cancel)
    ```

2. webView(_:didStartProvisionalNavigation:)

    컨텐츠를 로드하기 시작할 때 호출되는 메소드. URL이 유효하지 않거나 온라인 상태일 때에도 호출된다. 

3. webView(_:didCommit:)

    컨텐츠를 받기 시작할 때 호출되는 메소드. 대표적으로 로딩 상태 표시(주로 액티비티 인디케이터 뷰[Activity Indicator View]를 이용한다)

4. webView(_:didFinish:)

    웹뷰가 콘텐츠 로딩을 완전히 마쳤을 때 호출되는 메소드.

5. webView(_:didFail:withError:)

    로딩이 실패했을 때 호출되는 메소드. 응답을 아예 받지 못했을 때와는 달리, 웹 페이지를 불러오던 도중에 로딩이 실패했을 경우에 호출된다.

# 델리게이트 패턴을 이용한 웹 뷰의 로딩 처리