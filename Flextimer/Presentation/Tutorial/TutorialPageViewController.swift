//
//  TutorialPageViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/30.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RxSwift

class TutorialPageViewController: UIPageViewController {
  
  let disposeBag = DisposeBag()

  let pages: [UIViewController]
  
  lazy var pageControl = UIPageControl().then {
    $0.numberOfPages = self.pages.count
    $0.currentPage = 0
    $0.backgroundColor = UIColor.clear
  }
  
  let skipButton = UIButton().then {
    $0.backgroundColor = UIColor.clear
    $0.setTitle("건너뛰기", for: .normal)
    $0.setTitleColor(Color.secondaryText.withAlphaComponent(0.2), for: .normal)
    $0.titleLabel?.font = Font.REGULAR_16
  }
  
  let startButton = HistoryButton().then {
    $0.alpha = 0
    $0.isUserInteractionEnabled = false
    $0.setTitle("시작하기", for: .normal)
  }
  
  
  // MARK: - Init
  
  init() {
    let pageViewModelList: [TutorialViewModel] = [
      TutorialViewModel(
        "잠금화면에서도 간편한 사용",
        content: "위젯에 추가해 더욱 신속하게 출퇴근을 기록하고, 퇴근까지 남은 시간을 바로 확인하세요.",
        imageName: "tutorial_1"
      ),
      TutorialViewModel(
        "출근을 늦게 기록했어도",
        content: "바로 수정할 수 있으니깐! 오늘의 퇴근 예상 시간과 퇴근까지 남은 시간도 확인하세요.",
        imageName: "tutorial_2"
      ),
      TutorialViewModel(
        "스와이프해서 기록하기",
        content: "기록을 잊어버렸어도 문제없어요. 생성과 삭제, 휴무처리를 언제든지.",
        imageName: "tutorial_3"
      ),
      TutorialViewModel(
        "나에게 꼭 맞는 시스템",
        content: "설정에서 근무 시간과 요일을 선택할 수 있어요. 맞춤 기록 서비스를 사용해보세요.",
        imageName: "tutorial_4",
        isLast: true
      )
    ]
    
    self.pages = pageViewModelList.map { TutorialContentViewController($0) }
    
    super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    self.setViewControllers([self.pages[0]], direction: .forward, animated: true, completion: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Lifecycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.delegate = self
    self.dataSource = self
    self.view.backgroundColor = Color.immutableTutorialBackground
    
    self.setupConstraints()
  }
  
  fileprivate func setupConstraints() {
    self.view.addSubview(self.pageControl)
    self.view.addSubview(self.skipButton)
    self.view.addSubview(self.startButton)
    
    self.pageControl.snp.makeConstraints {
      $0.top.equalTo(self.view.snp.centerY).offset(100)
      $0.leading.trailing.equalToSuperview()
    }
    self.skipButton.snp.makeConstraints {
      $0.trailing.equalTo(self.view).offset(-20)
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-16)
      $0.height.equalTo(36)
    }
    self.startButton.snp.makeConstraints {
      $0.size.equalTo(CGSize(width: 120, height: 40))
      $0.centerX.equalTo(self.view)
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-24)
    }
    self.view.bringSubviewToFront(self.skipButton)
  }
}
