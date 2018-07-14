* 델리게이트 패턴(Delegate Pattern)

  * 일종의 위임 패턴
  
  * 객체지향 프로그래밍에서 하나의 객체가 모든 일을 처리하는 것이 아니라 처리해야 할 일 중 일부를 다른 객체에 넘기는 것. 
  대부분 GUI기반 프로그래밍에서 일반적으로 널리 사용되는 패턴.(대표적인 예 : 이벤트 리스너(Event Listener))
  
  * 특정 이벤트가 발생했을 때 알려주는 방법 = 미리 정의된 델리게이트 메소드를 사용하는 것.
  * IOS에서 델리게이트 패턴을 사용하는 모든 객체는 델리게이트 메소드를 정의한 프로토콜을 가진다.
  보통 객체의 이름 뒤에 Delegate를 붙여 정의한다.
  
> 패턴이란 ? 반복해서 나타나는 사건이나 형태. 예측 가능한 방식으로 되풀이된다는 점에서 의미가 있다.

# 텍스트 필드

텍스트 필드는 델리게이트 패턴을 사용하는 대표적인 객체중 하나. 
특정 문자열의 입력배제, 입력 가능한 문자열 길이 제한 등이 델리게이트 패턴을 통해 처리할 수 있는 대표적인 사례.

델리게이트 프로토콜을 구현하고 나면 해당 객체의 델리게이트 속성을 뷰 컨트롤러와 연결해야 한다. 
(델리게이트 속성이란, 델리게이트 메소드가 구현되어 있는 객체를 의미한다. 
특정 이벤트가 발생했을 경우 텍스트 필드는 이를 알려주기 위해 델리게이트 메소드가 구현되어 있는 객체를 찾게되는데, 
이를 위한 참조 포인터가 저장되는 곳이 delegate 속성이다.)

## 텍스트 필드의 특성

> 입력폼 안에 있는 X버튼? 어트리뷰트 인스펙터 탭에서 `Border Style`항목 아래를 보면 `Clear Button`항목이 있다.

> 텍스트 필드에 작성된 내용을 수정하기 위해 클릭하는 순간 기존에 있던 내용이 모두 지워지는 기능은? 
어트리뷰트 인스펙터 탭 > `Clear Button`항목 아래의 `Clear when editing begin`을 체크

* Capitalization : 입력시 첫 글자를 자동으로 대문자 처리
* Correction : 입력된 문자열을 바탕으로 이어질 입력값을 추측하고 가장 가능성이 큰 문자열을 추천하거나 자동으로 변환해주는 자동입력 기능
* Spell Checking : 내장된 사전을 바탕으로 입력된 단어의 철자를 비교하고, 잘못 입력되었을 경우 이를 알려주거나 바로잡는 역할
* Keyboard Type : 가상 키보드의 종류
* Appearence : 가상키보드의 색상 테마 지정
* Return Key : 가상 키보드에 나타나는 리턴 키의 스타일 설정
* Auto-enable Return Key : 텍스트 필드에 아무 값도 입력되지 않았을 때에는 리턴 키가 비활성화되어 있다가 값을 입력하는 순간 활성화 된다.
* Secure Text Entry : 비밀번호 입력처럼 ***로 표시할 필요가 있을 때 설정하는 항목

* 최초 응답자(First Responder)
  
  디스플레이에 앱의 콘텐츠를 표현하기 위해 사용하는 UIWindow객체는 사용자 인터페이스 구조에서 사용자에게 가장 가까이 위치한 객체로,
  사용자로부터 발생하는 터치 관련 이벤트를 내부 객체로 전달하는 역할을 한다. 
  이때 UIWindow는 이벤트가 발생했을때 우선적으로 응답할 객체를 가리키는 최초응답자(First Responder)라는 포인터를 가지고 있다. 
  (최초 응답자 = 포커스(Focus) 같은 개념)
  
  특정 객체를 최초 응답자로 지정하고 싶으면 객체에 대한 becomeFirstResponder() 메소드를 호출한다. 
  (메소드는 UIResponder 클래스에 정의되어 있으며, 이 클래스를 상속받은 객체는 모두 becomeFirstResponder 메소드 호출로 최초 응답자 객체가 될수 있다)
  
  최초 응답자 상태를 허용하지 않는 객체도 있는데, 
  화면에 키보드가 표시된 상태에서 다른 요소를 터치해도 그 객체가 UIResponder를 상속받지 않았다면 이벤트만 발생하고 포인터는 바뀌지 않는다.
  
  최초 응답자 상태를 해제하고자 할 경우 resignFirstResponder() 메소드를 호출해준다.
  
  스토리보드를 이용해서도 최초 응답자 설정이 가능하다. 
  (원하는 객체를 스토리보드에서 도크바의 First Responder 아이콘에 연결해 놓으면 화면이 실행될 때 자동으로 최초 응답자 객체로 지정된다.)
  
> becomeFirstResponder() 메소드를 사용해야 하는 이유? 프로세스 상에서 텍스트 필드를 직접 입력 준비 상태로 만들어주어야 할때 사용한다.

## 텍스트 필드에 델리게이트 패턴 적용하기

```swift
/* 객체에 델리게이트 지정 */
self.tf.delegate = self
```

텍스트 필드의 delegate는 텍스트 필드에 특정 이벤트가 발생했을때 알려줄 대상 객체를 가리키는 속성이다. 
self는 현재의 뷰 컨트롤러 인스턴스를 의미한다. (-> 텍스트 필드에서 미리 정해진 특정 이벤트가 발생하면 현재의 뷰 컨트롤러에게 알려달라는 요청)

이벤트 마다 호출하기로 한 약속된 메소드가 정해져 있는데, 현재 지정된 델리게이트 객체에서 이를 찾아 호출해준다.
(델리게이트 객체에 지정된 메소드 구현여부를 확인 -> 구현되어있다면 필요한 인자값을 담아 호출 / 구현되어 있지 않다면 그냥 스킵)

```swift

    //텍스트 필드의 편집을 시작할 때 호출
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        return true //false 를 리턴하면 편집되지 않는다
    }
    
    //텍스트 필드의 편집이 시작된 후 호출
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("텍스트 필드의 편집이 시작되었습니다")
    }
    
    //텍스트 필드의 내용이 삭제될 때 호출
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 내용이 삭제됩니다.")
        return true // false를 리턴하면 삭제되지 않는다
    }
    
    //텍스트 필드의 내용이 변경될 때 호출
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("텍스트 필드의 내용이 \(string)으로 변경됩니다.")
        
        if Int(string) == nil {
            if (textField.text?.count)! + string.count > 10 {
                return false
            } else {
                return true
            }
//            return true // 입력된 값이 숫자가 아니라면 true 를 리턴
        } else {
            return false //입력된 값이 숫자라면 false를 리턴
        }
//        return true  //false를 리턴하면 내용이 변경되지 않는다.
    }
    
    //텍스트 필드의 리턴키가 눌러졌을 때 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 리턴키가 눌러졌습니다")
        return true
    }
    
    //텍스트 필드 편집이 종료될 때 호출
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 종료됩니다.")
        return true
    }
    
    //텍스트 필드의 편집이 종료되었을때 호출
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("텍스트 필드의 편집이 종료되었습니다")
    }
```

# 이미지 피커 컨트롤러

이미지 피커 컨트롤러는 화면 전체를 덮기 때문에 운영체제가 일시적으로 앱에 대한 제어 권한을 가져간다. 
사진을 촬영하거나 앨범에서 사진을 선택하면 그 이미지 정보를 델리게이트로 지정된 객체에 메소드 호출을 통해 
인자값으로 전달해주어 우리가 선택한 이미지를 사용할 수 있도록 해준다.

## UIImagePickerController 클래스

이미지 피커 기능은 UIImagePickerController 클래스에 구현되어 있다. UIViewController를 상속받은 컨트롤러이기때문에 화면전환하는 방식을 이용한다. 
스토리보드를 이용하여 구현할 수는 없으며, 소스코드를 사용하여 직접 인스턴스를 생성하고 화면을 호출해야 한다.

```swift
        //이미지 피커 컨트롤러 인스턴스 생성
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary //이미지 소스로 사진 라이브러리 선택
        picker.allowsEditing = true //이미지 편집 기능 on
        picker.delegate = self
        
        //이미지 피커 컨트롤러 실행
        self.present(picker, animated: false)
        
        //이미지 피커 컨트롤러 종료
        picker.dismiss(animated: false)
```

* UIImagePickerControllerSourceType

  * UIImagePickerControllerSourceType.photoLibrary : 이미지 라이브러리에서 이미지를 선택하는 옵션
  * UIImagePickerControllerSourceType.savedPhotosAlbum : 저장된 사진 앨범에서 이미지를 선택하는 옵션
  * UIImagePickerControllerSourceType.camera : 카메라를 실행하여 즉석에서 사진을 촬영하고 이를 통해 이미지를 생성하는 옵션
  
* allowsEditing 속성

  * 수정이나 보정, 또는 필요한 부분만 잘라내기 등의 편집작업을 할 것인지에 대한것.
  
* delegate 속성

  * 선택한 이미지를 반환받을 대상 지정. 프로토콜을 추가하지 않은 상태에서 delegate 속성에 self를 입력하면 오류가 발생하므로 주의해야 한다.
  (필요한 프로토콜은 UIImagePickerControllerDelegate, UINavigationControllerDelegate)
  
이미지 피커 실행을 종료하고 원래의 화면으로 돌아올때도 `dismiss(animated:)`메소드를 호출하는 방식으로 복귀한다.

## 이미지 피커 컨트롤러의 델리게이트 메소드

* imagePickerController(_:didFinishPickingMediaWithInfo:)

  * 이미지를 선택하거나 카메라 촬영을 완료했을 때 호출. 첫번째 인자값은 메소드를 호출하는 이미지 피커 컨트롤러 객체. 
  두번째 인자값은 원하는 이미지에 대한 데이터.(이미지 객체에 대한 종합정보가 딕셔너리 형태로 전달된다)
  
    * UIImagePickerControllerMediaType : 전달받는 미디어 타입에 대한 정보
    * UIImagePickerControllerOriginalImage : 선택한 이미지에 대한 원본 이미지 데이터. 수정되었더라도 이 키를 이용하면 원본 획득 가능.
    * UIImagePickerControllerEditedImage : 수정된 경우 수정된 이미 전달
    * UIImagePickerControllerCropRect : 크롭(Crop, 사각형으로 잘라내는것)된 경우 크롭된 이미지 전달.
    
* imagePickerControllerDidCancel(_:)

  * 이미지 피커 컨트롤러가 실행된 후 이미지 선택 없이 그냥 취소했을 때 호출되는 메소드.

## 이미지 피커 컨트롤러 실습

이미지를 화면에 표현할 때에는 이미지 파일을 이용하여 UIImage 객체를 만들고, 이를 다시 UIImageView에 넣어서 표현해주어야 한다.

* 델리게이트 메소드 구현

```swift
//UIImagePickerControllerDelegate, UINavigationControllerDelegate 프로토콜 추가
~ ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
...
//델리게이트를 지정
picker.delegate = self
...
    //이미지 피커에서 이미지를 선택하지 않고 취소했을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false) { () in
            //알림창 호출
            let alert = UIAlertController(title: "", message: "이미지 선택이 취소되었습니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
    }
    
    //이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false) { () in
            //이미지를 이미지 뷰에 표시
            let img = info[UIImagePickerControllerEditedImage] as? UIImage
            self.imgView.image = img
        }
    }
    
```

일단 델리게이트 메소드를 구현하게되면 컨트롤러 창을 닫기 위한 dismiss(animated:)메소드를 직접 호출해주어야 이미지 피커창이 닫히고 원래의 뷰로 돌아올 수 있다.
picker.dismiss(animated:)메소드가 호출되면 자신이 치워야 할 뷰컨트롤러가 있는지 확인하고, 그렇다면 치우지만 아닌경우 잘못된 요청으로 간주하고
self.presentingViewController에 해당하는 객체에 요청을 전달한다.

매개변수 info에는 사용자가 선택한 이미지 정보가 담겨서 전달되기 때문에, UIImage 타입으로 캐스팅한 다음 이미지 객체로 사용할 수 있다. 
추출된 이미지 정보를 이미지뷰의 .image 속성에 대입하면 끝.

## 익스텐션(Extension)을 이용한 델리게이트 패턴 코딩

클래스를 대신하여 프로토콜을 구현할 수 있기 때문에 델리게이트 패턴에 사용되는 프로토콜을 익스텐션에서 구현하면
하나의 뷰 컨트롤러 클래스에 여러 프로토콜 메소드가 난립하는것을 방지할 수 있다.

```swift
//MARK: -이미지 피커 컨트롤러 델리게이트 메소드
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
...
```

파일에 익스텐션을 구현해주고 프로토콜에서 구현해야 할 메소드를 작성하면 끝.(1익스텐션 1프로토콜 로 작성하는것도 더 깔끔해보일 수 있다)

> 스위프트가 제공하는 주석인 `//MARK:-블라블라` 를 사용하면 점프바에서 유용하게 사용 가능.
