테이블 뷰 관련 메소드들을 이용하여 목록을 화면에 구현할 때 만들어야 할 셀의 개수가 30개라고 해서 처음부터 무조건 30개의 셀을 만들지 않는다.

# 테이블 뷰를 스크롤할 때 발생하는 일들

화면에 표시해야 할 만큼만 tableView(_:cellForRowAt:) 메소드를 호출하여 셀을 구성하고 나머지는 대기 상태로 두어 이후에 가려진 나머지 셀이 표시되어야 하는 순간에 tableView(:cellForRowAt:)메소드를 추가로 호출하여 필요한 셀을 구성한다.

## 재사용 메커니즘

iOS특유의 부드러운 화면을 위해 사용되는 몇가지 메커니즘 중 하나.

```
tableView.dequeueReusableCellWithIdentifier("ListCell") as! MovieCell
```
메소드가 재사용 큐에서 사용 가능한 셀을 확인하여 없으면 새로 생성하고 있으면 꺼내어 사용함.

재사용 큐에 저장된 셀 자체는 재사용하지만 컨텐츠는 tableView(_:cellForRowAt:)메소드를 통해 매번 새롭게 구현된다.

> 부드러운 인터페이스를 위한 원칙
1. 반복적으로 호출되는 메소드의 내부에는 네트워크 통신 등 처리 시간이 긴 로직을 포함하지 않는다.
2. 네트워크 통신을 통해 읽어온 데이터는 재사용 할 수 있도록 캐싱(caching)처리하여 네트워크 통신횟수를 줄이는 것이 좋다.
3. 네트워크 통신이나 시간이 오래 걸리는 코드를 사용할 때는 비동기(Asynchronize)로 처리하는것이 바람직하다

`메모제이션(memoization)` 기법 : 프로그램이 동일한 계산을 반복해야 할 때 이전에 계산한 값을 메모리에 저장함으로써 반복 수행을 제거하고 프로그램의 실행 속도를 빠르게 하는 기술.

`블로킹(Blocking)` : 하나의 긴 요청을 처리하는 동안 다른 요청은 처리할 수 없게 되어 앞의 처리가 끝날 때까지 대기 상태가 발생하는 경우

## 이미지 비동기 처리하기

* 스위프트에서 제공하는 비동기 구현
    * 델리게이트 패턴 : 네트워크 통신 자체에만 국한됨. NSURLConnectionDelegate 객체를 이용한다. 델리게이트 객체에 처리를 위임한 후 완료되면 델리게이트 객체가 특정 메소드를 호출하게 하여 이 메소드 내부에 처리할 작업을 정의하는 방식.
    * iOS가 제공하는 범용 비동기 함수 : DispatchQueue.main.async() 제공. 블록(Block)과 GCD(Global Centeral Dispatch=애플에서 개발한 기술로 병렬처리와 스레드풀에 기반을 둔 비동기방식을 구현해준다)를 이용한다. 개발자가 내부적으로 프로세스나 스레드에 직접 접근하지 않고도 비동기방식으로 처리할 수 있다. 글로벌 범위에서 사용할 수 있다.

```
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    ...
    DispatchQueue.main.async(execute: {
        cell.thumbnail.image = self.getThumbnailImage(indexPath.row)
    })
```

클로저의 특성상 연관된 외부 범위 변수를 그대로 사용할 수 있어 인자값으로 전달되지 않은 cell 객체도 내부에서 참조가 가능하다. 클로저는 내부 함수에서 사용되는 외부 환경을 계속 유지해주는 특성때문에 cell 객체가 제거되지 않고 계속 살아있을 수 있다.

# 일반 뷰 컨트롤러에서 테이블 뷰 사용하기

스토리 보드 파일에서 테이블 뷰를 상단 뷰 컨트롤러 아이콘으로 드래그 하여 `dataSource와 `delegate에 연결 해야 한다.(클래스에 데이터소스나 델리게이트를 사용하는 객체가 추가되면 이 객체가 필요한 메소드를 어디서 찾을 수 있는지에 대한 참조정보를 알려줘야함)

```
//스토리보드가 아닌 소스코드에서 연결할 때
self.tableView.dataSource = self
self.tableView.delegate = self
```

dataSource를 연결하지 않으면 tableView(_:numberOfRowsInSection:), tableView(_:cellForRowAt:)메소드를 호출할 수 없으므로 delegate를 연결하지 않으면 테이블 뷰의 모양과 목록은 갖추어 졌더라도 테이블 뷰에 대한 액션이나 이벤트를 처리할 수 없게 됩니다.