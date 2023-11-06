# TimeToFast!
<img src="https://github.com/eunbkang/TimeToFast/assets/103012157/61409942-0a15-437d-a175-b8a4b6895661">

[<img width="160" src="https://github.com/eunbkang/TimeToFast/assets/103012157/42dbcd0c-141d-42c7-af86-5f66877236ff">](https://apps.apple.com/kr/app/단식할-시간-공복시간-타이머/id6470159635)

## Features
공복시간, 식사시간을 알려주는 타이머로 간헐적 단식 스케줄을 쉽게 파악하세요. 현재 상태와 남은 시간이 하루 시간표에 맞게 표시돼요. 
단식 계획은 간편하게 수정할 수 있고, 단식 시간이 끝나면 결과를 저장할 수 있어요. 지난 단식 기록도 볼 수 있답니다!

- 타이머 시작/정지 버튼을 누르면 설정한 플랜에 맞게 타이머가 실행돼요.
- 타이머 동작 중에도 단식 플랜을 수정할 수 있어요.
- 미리 등록된 다섯 가지 형태의 단식 플랜 중 하나를 선택하고, 식사 시간을 설정해요.
- 단식 시간 중에는 이번 단식을 시작한 시간을 편집할 수 있어요.
- 식사 시간 중에는 지난 단식 결과를 편집하고 저장할 수 있어요.
- 단식 시간 중, 오늘 더이상 단식이 힘들다면 ‘단식 쉬기’ 버튼을 눌러 단식을 일찍 끝내고 저장할 수 있어요.
- 이번 주 단식 기록을 그래프로 볼 수 있고, 지난 기록은 달력에서 목표 달성 여부와 함께 확인할 수 있어요.
- 단식시간 알림을 설정하면 단식 시작/종료 알림을 받을 수 있어요.

## Screenshots
<img alt="Screenshot 2023-11-06 at 9 29 43 PM" src="https://github.com/eunbkang/TimeToFast/assets/103012157/e45040cd-5826-47ec-9eb0-ffb34b7ba1e5">

## 개발 기간
2023.9.25 - 2023.10.25

## 개발 환경
- Minimum Deployment: iOS 16.0
- Xcode Version: 14.3.1
- Package Dependency Manager: Swift Package Manager

## Tech Stack
- UIKit, SwiftUI, CodeBase, MVVM
- Timer, UIBezierPath
- UserDefaults, UserNotifications
- WidgetKit
- Localization
- Realm, FSCalendar, DGCharts, SnapKit
- Firebase Analysis, Crashlytics

## 구현 기능

- `Observable` 클래스 이용하여 MVVM 패턴 적용
- 단식 상태 타이머 화면 구현
    - UserDefaults에 저장된 단식 계획과 현재시간으로 공복/식사시간 상태 판단 후 타이머 설정
    - `Timer` 클래스 이용하여 공복/식사 남은시간 카운트다운 및 시간 흐름에 따른 상태 판단
    - 타이머 상태 및 유저의 단식 결과 저장 상태에 따라 단식 기록 카드 UI 및 데이터 교체
    - 시간을 각도로 변환하여 `UIBezierPath`의 각도를 설정하고 `CAShapeLayer`에 적용하여 원형 하루 시간표 구현
    - delegate 패턴 이용하여 유저가 설정한 시간을 타이머 화면으로 값 전달
    - 하루에 하나의 기록만 Realm에 저장하도록 하는 로직 구현
- 단식 계획 설정 화면 구현
    - `UserDefaultsManager` 싱글톤 객체의 연산 프로퍼티로 단식 계획 읽기/저장 구현
    - 계획 저장 시 단식/식사 시작 시간으로 `UserNotification` 설정
- 단식 기록 화면 구현
    - `UIScrollView`로 전체 화면 스크롤 가능하도록 구성
    - `DGCharts`를 이용하여 최근 7일 기록 보기 구성, `FSCalendar`를 이용하여 달력으로 지난 기록 보기 구성
- 위젯 구현
    - SwiftUI를 이용하여 `systemSmall` 크기의 타이머 화면 위젯 구현
    - 시간에 따른 뷰 업데이트를 위해 복수의 `TimelineEntry`를 생성하고 공복/식사 시간 시작 시점에 `Timeline` 갱신 정책 적용
    - App Groups 설정하여 앱과 Widget Extension 간 UserDefaults 저장 데이터 공유
- 국문, 영문 Localization 적용

## Version History

|Version|Date|New in this version|Details|
|:-:|:-:|:-:|:-|
|1.0.0|2023.10.25|최초 출시||
|1.0.1|2023.10.26|버그 수정 및 사용성 개선|위로 스와이프하여 백그라운드로 갈 때 배경이 깜빡거리는 문제 해결<br>타이머 시작 시 식사 중 상태일 때도 1초동안 단식 중으로 나타나는 문제 해결|
|1.0.2|2023.10.27|버그 수정 및 사용성 개선|단식 결과 시작/종료시간 최대/최소값 설정<br>달력 이전/다음 달 버튼 추가|
|1.1.1|2023.10.31|타이머 위젯 추가|systemSmall 크기 타이머 화면 위젯 추가<br>단식 쉬는 상태에서 저장하고 앱 재실행 시 저장 안된 상태로 나오는 문제 해결|
|1.1.2|2023.11.04|버그 수정 및 사용성 개선|막대그래프 최대/최소 범위 고정<br>Analytics 집계 안되는 문제 해결|
