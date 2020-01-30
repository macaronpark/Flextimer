//
//  TutorialPageViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/30.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class TutorialPageViewController: BaseViewController {
  
  let tutorials = [
    Tutorial(
      index: 0,
      title: "잠금화면에서도 간편한 사용",
      content: "위젯에 추가해 더욱 신속하게 출퇴근을 기록하고, 퇴근까지 남은 시간을 바로 확인하세요.",
      imageName: "tutorial_1"
    ),
    Tutorial(
      index: 1,
      title: "출근을 늦게 기록했어도",
      content: "바로 수정할 수 있으니깐! 오늘의 퇴근 예상 시간과 퇴근까지 남은 시간도 확인하세요.",
      imageName: "tutorial_2"
    ),
    Tutorial(
      index: 2,
      title: "스와이프해서 기록하기",
      content: "기록을 잊어버렸어도 문제없어요. 생성과 삭제, 휴무처리를 언제든지.",
      imageName: "tutorial_3"
    ),
    Tutorial(
      index: 3,
      title: "나에게 꼭 맞는 시스템",
      content: "설정에서 근무 시간과 요일을 선택할 수 있어요. 맞춤 기록 서비스를 사용해보세요.",
      imageName: "tutorial_4"
    )
  ]
  
//  lazy var pageViewController = UIPageViewController(
//    transitionStyle: .scroll,
//    navigationOrientation: .horizontal,
//    options: nil
//  ).then {
//    $0.delegate = self
//    $0.dataSource = self
//  }
  
  let pageControl = UIPageControl().then {
    $0.numberOfPages = 4
    $0.currentPage = 0
  }
  
//  var currentIndex: Int?
//
//  var viewControllers = [TutorialContentViewController]()
  
  
  // MARK: - Lifecycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = Color.immutableTutorialBackground
  }
}
