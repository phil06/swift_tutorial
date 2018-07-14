앱 내에서 사용자에게 메시지를 전달하는 대표적인 방법
    
* 메시지창(알림창)
* 로컬 알림
    
    앱 내부에서 특정 프로세스에 의해 등록된 메시지를 IOS가 전달하는 방식
* 서버 알림(푸시 알림)

    별도의 서버를 통해 APNS라는 애플 고유의 메시징 시스템에게 보낸 메시지가 네트워크를 통해 전달되는 방식

# 메시지 알림창 - UIAlertController

* 알림창
    
    화면 중앙에 표시됨.
    버튼이 두개일때 나란히 배치됨.
    모달(Modal)방식 (=창이 닫힐 때까지 그 창을 제외한 화면의 다른 부분은 반응할 수 없도록 잠기는것)
* 액션시트

    화면 하단에 표시됨.
    버튼을 세로로 배치함.
    메시지가 떠 있는 동안에도 메시지 창이 아닌 다른 영역을 건드릴 수 있으며, 그 결과로 액션 시트 창이 닫힌다.

> 알림창이 표시되는 동안 코드는 계속 실행됩니다. 
    
    사용할 수 없는 범위는 사용자의 터치 또는 드개르와 같은 이벤트로 제한됨.
    즉, 알림창이 애플리케이션의 실행 자체를 멈추는 것은 아니므로 주의해야 함.
    UIAlertController가 비동기 방식으로 실행되기 때문.

## UIAlertController

```swift
let alert = UIAlertController(title: "알림",
                              message: "UIAlertController 샘플 알림창입니다",
                              preferredStyle: UIAlertControllerStyle.alert)
let cancel = UIAlertAction(title: "취소",
                           style: 
                           UIAlertActionStyle.cancel)
alert.addAction(cancel)
self.present(alert, animated: false)
```

UIAlertController가 메시지 창 그 자체를 담당.

UIAlertAction은 메시지 창에 들어갈 버튼을 구현.

세번째 매개변수인 preferredStyle은 알림창과 액션 시트를 결정하는 값.(actionSheet/alert)
읽기전용 속성으로 값을 설정할 수 있는것은 인스턴스를 생성할 때만 가능하다. 설정하지 않은경우 default값은 .actionSheet 이다.

UIAlertAction 인스턴스 생성시 버튼 클릭후에 대한 로직을 수행하고 싶다면 세번째 매개변수를 함수나 클로저 형태로 추가할 수 있다.(이때 버튼 객체에 대한 참조 정보[UIAlertAction]도 인자값으로 전달됨)

> 열거형의 축약 표현

    열거형 타입으로 변수나 상수가 이미 정의되어 있다면 값을 대입할 때 열거형 객체의 이름을 생략하고 값만 선택해서 입력 가능. (UIalertControllerStyle.alert -> .alert)

> UIAlertActionStyle

    default : 일반적인 스타일
    cancel : 하나만 존재 가능
    destructive : 중요한 내용을 변경하거나 삭제해서 되돌릴 수 없는 결정을 하는 버튼에 적용.빨간색으로 강조된다.

보통 추가하는 순서대로 버튼이 나열되지만 .cancel 속성의 버튼은 항상 메시지 창의 마지막에 위치함.(.actionSheet 일 경우에도 동일하게 제일 아래에 분리되어 표시된다.)

> API문서 보는방법 : Shift + Command + 숫자0

뷰 객체가 메모리에만 올라온 상태에서 호출되는 viewDidLoad() 메소드와 달리 viewDidAppear()메소드는 뷰가 완전히 화면에 표시되고 난 다음에 호출되기 때문에 메시지 창을 띄우기 위한 프레젠트 메소드를 실행하기 좋음.

## 입력 필드를 가지는 메시지 창

```swift
alert.addTextField(configurationHandler: { (tf) in
    tf.placeholder = "암호"
    tf.isSecureTextEntry = true
})
```

텍스트 필드를 추가할 때에는 버튼처럼 별도의 객체를 생성하여 등록하는 방식이 아니라 `addTextField(configuration Handler:)` 메소드를 호출하면 된다. 이 클로저의 목적은 추가된 텍스트 필드의 속성을 설정하는것. 클로저가 직접 참조할 수 있도록 텍스트 필드 객체 정보가 클로저의 인자값으로 전달됨.

```swift
let ok = UIAlertAction(title:"확인", style:.default) { (_) in
    if let tf = alert.textFields?[0] {
        print("입력된 값은... \(tf.text!) 입니다")
    } else {
        print("입력된게 없음")
    }
})

```

메시지 창에 추가된 텍스트 필드는 textFields 속성을 통해 참조가능.
첫번째 인자값을 가리키는 속성이 .first 를 이용 할 수도 있음.

> 클로저의 다양한 표현 방식
* 원형
```swift
.....: { (textfield: UITextField) in ..... })
```
* 변형1 (클로저 인자값 대신에 메소드에 실행 블록 추가)
```swift
.... ) { (textfield: UITextField) in .... }
```
* 변형2 (클로저 인자값의 타입 생략)
```swift
....) { (tf) in ...... }
```
* 변형3 (클로저 인자값을 생략)
```swift
.....) { 
    //인자값을 $0 으로 대체
    $0.placeholder = ...
}
```

# 로컬 알림

앱 내부에서 만든 특정 메시지를 IOS의 알림 센터를 통해 전달하는 방법.

IOS 스케줄러에 의해 발송된다. IOS스케줄러에 등록 해두면 해당 시각에 맞추어 자동으로 발송됨. 앱이 실행중이 아니더라도 메세지를 받을 수 있으며, 표시된 메세지를 클릭하여 앱을 실행시키고 원하는 기능을 실행하거나 특정화면으로 이동하게끔 처리 할 수 있다.

IOS 10버전 이상부터는 UserNotification 프레임워크를, 그 이외에는 UILocalNotification 객체를 이용해서 로컬 알림을 구현해야 함.

## UserNotification 프레임워크를 이용한 로컬 알림

UN***로 시작하는 객체를 보면 알림 처리를 위한 객체라고 생각하면 된다. 사용을 위해 파일 상단에 반입 구문 추가

```swift
import UserNotification
```

* UNMutableNotificationContent

    메시지와 같은 기본적인 속성을 담는 알림 콘텐츠 역할. 아이콘에 표시될 배지나 사운드 설정. (UNNotificationContent 는 수정이 불가능하며 객체로부터 속성을 읽어 들일 수 만 있는 특성을 가진다)

* UNTimeIntervalNotificationTrigger

    알림 발송 조건을 관리함. (시간/반복여부) 특정 시간에 맞춰 발송하고자 하는경우 UNCalendarNotificationTrigger 를 사용.

* UNNotificationRequest

    알림 요청.

* UNUserNotificationCenter

    실제 발송을 담당하는 센터. 등록된 알림 내용을 확인하고 정해진 시각에 발송하는 역할. 싱글턴 방식으로 동작하기 때문에 인스턴스를 생성하지 않고 current() 메소드를 통해 참조정보만 가져올 수 있다.
    (UNUserNotificationCenter.current() 를 이용해 인스턴스를 가져옴)

    UNNotificationRequest 객체를 `UNUserNotificationCenter#add(_:)` 메소드를 이용해 추가하기만 하면 알림등록 과정이 완료된다.

## 기본 실습

```swift
let notiCenter = UNUserNotificationCenter.current()
notiCenter.requestAuthorization(options: [.alert, .badge, .sound])  { (didAllow, e) in
    ...
}
```

requestAuthorization() 메소드를 호출하여 사용자에게 알림설정에 대한 동의를 받는다.

UserNotification 프레임워크에서는 UNUserNotificationCenter 객체를 이용하여 미리 알림 설정 환경을 정의하고, 설정내용을 사용자에게 승인받는 과정을 거쳐야 한다.

options: 알림메세지에 포함될 항목들

두번째 인자값 클로저 : 사용자 동의 메세지 창의 동의 여부를 true/false 형태로 전달받는 첫번째 매개변수와 오류발생시 사용하는 오류 객체 타입의 두번째 매개변수를 받는다.

```swift
UNUserNotificationCenter.current().getNotificationSettings { settings in 
    if settings.authorizationStatus == UNAuthorizationStatus.authorized {
        let nContent = UNMutableNotificationContent()
        ....
    }
}
```

알림메세지를 보내기 위해 맨 먼저 확인해야 하는것은 사용자의 동의 여부이다.

```swift
let nContent = UNMutableNotificationContent()
nContent.badge = 1
nContent.title = "로컬 알림 메시지"
nContent.subtitle = "준비된 내용이 아주 많아요! 얼른 다시 앱을 열어주세요!!"
nContent.body = "앗! 왜 나갔어요?? 어서 들어오세요!!"
nContent.sound = UNNotificationSound.default()
nContent.userInfo = ["name":"홍길동"]

let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)

UNUserNotificationCenter.current().add(request)
```

`applicationWillResignActive(_:)` : 앱이 활성화 상태를 잃었을 때 실행되는 메소드

`if #available()` : 플랫폼 버전에 따라 실행 로직 구분

> nContent.badge = 1

앱 아이콘에 표시될 값. 사용자가 확인하지 않은 알림이 있음을 암시한다.

> nContent.sound = UNNotificationSound.default()

알림이 도착했을 때 알려줄 사운드 설정

> nContent.userInfo = ["name":"홍길동"]

로컬 알림과 함께 전달하고 싶은 값이 있을 때 사용. 알림을 눌러서 연결되는 앱 델리게이트 메소드에서 참조 할 수 있다.

> let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)

identifier : 해당 알림에 대한 임의의 식별 아이디

content : 발송할 내용

trigger : 정의한 발송 시각 조건

## 받은 알림 처리하기

`사용자가 알림을 클릭했을 때 감지할 수 있는 방법`

델리케이트에 UNUserNotificationCenterDelegate 프로토콜을 추가후, UNUserNotificationCenter 객체에 `~.delegate = self` 추가. 

앱이 실행되는 도중에 알림 메시지가 도착할 경우 `userNotificationCenter(_:willPresent:withCompletionHandler:)` 메소드가 자동으로 호출된다. 알림 배너의 표시 여부와 상관없이 호출되므로 completionHandler() 메소드를 꼭 호출해줘야 알림 배너가 표시된다.

사용자가 알림 메시지를 클릭하면 `userNotificationCenter(_:didReceive:withCompletionHandler:)` 메소드가 자동으로 호출된다. 알림 메시지에 대한 정보는 두번째 인자값인 response 매개변수에 담겨 전달된다.

두 메소드는 프로토콜 추가후 구현해주어야 함

> @available(iOS 10.0, *) : 특정 버전부터 사용할수 있음을 의미하는 어노테이션

## UILocalNotification 객체를 이용한 로컬 알림

## 받은 알림 처리하기

```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
...
            if let localNoti = launchOptions?[UIApplicationLaunchOptionsKey.localNotification] as? UILocalNotification {
                //알림으로 인해 앱이 실행된 경우이다. 이때에는 알림과 관련된 처리를 해 준다.
                print((localNoti.userInfo?["name"])!)
            }
        }
        
        return true
    }
````

사용자가 알림 메세지를 눌러 앱을 실행했다면 launchOptions에는 UIApplicationLaunchOptionKey.localNotification 키와 그에 해당하는 값이 저장된다. (launchOptions는 딕셔너리 타입의 매개변수)

> 앱 아이콘을 클릭하여 실행하는 경우에는 배지가 설정되어 있더라도 알림 액션과는 무관한 실행으로 간주된다.

앱이 실행중인 상태에서 알림이 도착한다면 활성화/비활성화 상태와 관계없이 앱 델리게이트의 application(_:didReceive:) 메소드가 호출된다.

활성화 상태와 비활성화 상태를 구분해서 로직을 처리해 주려면 UIApplication 객체에서 제공하는 applicationState 속성을 이용하면 된다.

## 미리 알림 기능 구현

* DispatchQueue.main.async { ... } 의 역할?

    백그라운드에서 실행되는 로직을 메인 쓰레드에서 실행되도록 처리해주는 역할. IOS의 실행영역은 UI등의 주요 처리를 담당하는 메인과 중요하지 않는 처리를 담당하는 백그라운드 영역으로 나뉜다. 대부분의 비동기 클로저 구문은 백그라운드 영역에서 실행되는데 메인에서 실행되어야 하는 경우에 해당하는 부분을 감싸주면 범위내의 코드는 메인 영역에서 실행된다.

> datepicker 는 시스템에 설정된 시각을 따르지만 날짜시간으로 표현할때 GMT 기준으로 보여주기 때문에 addingTimeInterval(..) 메소드를 이용하여 원하는 시간을 더해주어야 한다.