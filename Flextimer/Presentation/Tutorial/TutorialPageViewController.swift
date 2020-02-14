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
  
  enum Text {
    static let SKIP = "Skip".localized
    static let START = "Start".localized
    static let TUTORIAL_TITLE_1 = "Easy to use on lock screen".localized
    static let TUTORIAL_CONTENT_1 = "Add to the widget to record your start and end time more quickly, and check your remaining time easily.".localized
    static let TUTORIAL_TITLE_2 = "Even if you recorded late".localized
    static let TUTORIAL_COTENT_2 = "It's fine. Just create new record and fix the start time anytime!".localized
    static let TUTORIAL_TITLE_3 = "Swipe to record".localized
    static let TUTORIAL_CONTENT_3 = "It doesn't matter even if you totally forgot to record. Create, edit, and delete at any time.".localized
    static let TUTORIAL_TITLE_4 = "Customizable system".localized
    static let TUTORIAL_CONTENT_4 = "In Settings, customize the work hours and days of the week.".localized
  }
  
  let disposeBag = DisposeBag()

  let pages: [UIViewController]
  
  lazy var pageControl = UIPageControl().then {
    $0.numberOfPages = self.pages.count
    $0.currentPage = 0
    $0.backgroundColor = UIColor.clear
    $0.isUserInteractionEnabled = false
  }
  
  let skipButton = UIButton().then {
    $0.backgroundColor = UIColor.clear
    $0.setTitle(Text.SKIP, for: .normal)
    $0.setTitleColor(Color.secondaryText.withAlphaComponent(0.2), for: .normal)
    $0.titleLabel?.font = Font.REGULAR_16
  }
  
  let startButton = HistoryButton().then {
    $0.alpha = 0
    $0.isUserInteractionEnabled = false
    $0.setTitle(Text.START, for: .normal)
  }
  
  
  // MARK: - Init
  
  init() {
    let pageViewModelList: [TutorialViewModel] = [
      TutorialViewModel(
        Text.TUTORIAL_TITLE_1,
        content: Text.TUTORIAL_CONTENT_1,
        imageName: "tutorial_1"
      ),
      TutorialViewModel(
        Text.TUTORIAL_TITLE_2,
        content: Text.TUTORIAL_COTENT_2,
        imageName: "tutorial_2"
      ),
      TutorialViewModel(
        Text.TUTORIAL_TITLE_3,
        content: Text.TUTORIAL_CONTENT_3,
        imageName: "tutorial_3"
      ),
      TutorialViewModel(
        Text.TUTORIAL_TITLE_4,
        content: Text.TUTORIAL_CONTENT_4,
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
    self.bind()
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
    self.view.bringSubviewToFront(self.startButton)
  }
  
  func bind() {
    let skipButton = self.skipButton.rx.tap
    
    skipButton
      .map { [weak self] in self?.pages.last ?? TutorialContentViewController() }
      .bind(onNext: { [weak self] in
        self?.setViewControllers([$0], direction: .forward, animated: true, completion: nil)
      }).disposed(by: self.disposeBag)
      
    skipButton
      .map { [weak self] in (self?.pages.count ?? 1) - 1 }
      .bind(to: self.pageControl.rx.currentPage)
      .disposed(by: self.disposeBag)
    
    skipButton
      .map { true }
      .bind(to: self.skipButton.rx.isHidden)
      .disposed(by: self.disposeBag)
    
    skipButton
      .map { true }
      .bind(to: self.startButton.rx.isUserInteractionEnabled)
      .disposed(by: self.disposeBag)
    
    skipButton
      .bind(onNext: { [weak self] in
        UIView.animate(withDuration: 1, animations: {
          self?.startButton.alpha = 1
        })
      }).disposed(by: self.disposeBag)
    
    self.startButton.rx.tap
      .subscribe { [weak self] _ in
        if let userInfo = RealmService.shared.realm.object(ofType: UserInfo.self, forPrimaryKey: 0) {
          RealmService.shared.update(userInfo, with: ["isTutorialSeen": true])
        }
        self?.dismiss(animated: true, completion: nil)
    }.disposed(by: self.disposeBag)
  }
}
