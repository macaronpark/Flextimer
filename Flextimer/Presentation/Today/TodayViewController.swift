//
//  TodayViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/10.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RealmSwift
import RxCocoa
import RxSwift

class TodayViewController: BaseViewController {
  
  let isWorking = BehaviorRelay(value: false)
  let todayView = TodayView()
  var todayViewModel: TodayViewModel!
  var notificationToken: NotificationToken? = nil
  
  let settingBarButton = UIBarButtonItem(
    image: UIImage(named: "navi_setting")?.withRenderingMode(.alwaysOriginal),
    style: .plain,
    target: nil,
    action: nil
  )
  
  
  // MARK: - Init
  
  override init() {
    super.init()
  }
  
  convenience init(_ viewModel: TodayViewModel) {
    self.init()
    
    self.todayViewModel = viewModel
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  
  // MARK: - Lifecycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.registerNotification()
  }
  
  override func setupNaviBar() {
    super.setupNaviBar()
    
    self.title = "오늘의 근태"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationItem.setRightBarButton(self.settingBarButton, animated: true)
  }
  
  
  // MARK: - Bind
  
  override func bind() {
    super.bind()
    
    self.todayView.optionView.rx.viewModel
      .onNext(self.todayViewModel)
    
    // 초기화
    Observable
      .just(self.todayViewModel.isWorking)
      .asObservable()
      .bind(to: self.isWorking)
      .disposed(by: self.disposeBag)
    
    let share = self.isWorking.asObservable()
    
    share
      .debug("🧐isWorking🧐")
      .bind(to: self.todayView.buttonsView.rx.viewModel)
      .disposed(by: self.disposeBag)
    
    share
      .map { (self.todayViewModel, $0) }
      .bind(to: self.todayView.stackView.rx.viewModel)
      .disposed(by: disposeBag)
    
    share
      .filter { $0 == false }
      .bind(to: self.todayView.timerView.rx.resetTimer)
      .disposed(by: disposeBag)

    share
      .debug("timer")
      .flatMapLatest { $0 ? Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance): .empty() }
      .map { _ in self.todayViewModel }
      .bind(to: self.todayView.timerView.rx.viewModel)
      .disposed(by: disposeBag)
    
    self.todayView.buttonsView.startButton.rx.tap
      .bind(onNext: { [weak self] in self?.didTapStartButton() })
      .disposed(by: self.disposeBag)
    
    self.todayView.buttonsView.endButton.rx.tap
      .bind(onNext: { self.showEndAlert() })
      .disposed(by: self.disposeBag)
    
    // TODO: 탭 시 출근시간 변경할 수 있게
//    self.todayView.stackView.startCellButton.rx.tap
//      .flatMapLatest { [weak self] _ -> Observable<Date> in
//        return DatePickerViewController.date(
//          parent: self,
//          current: self?.todayViewModel.s,
//          mode: .date,
//          doneButtonTitle: "기록 조회"
//        ).skip(1)
//    }.bind { [weak self] date in
//      self?.displayedDate.accept(date)
//      self?.willScrollToSelectedDate.onNext(true)
//    }
//    .disposed(by: self.disposeBag)
      
    self.settingBarButton.rx.tap
      .map { UINavigationController(rootViewController: SettingViewController()) }
      .bind { [weak self] in
        self?.navigationController?.present($0, animated: true, completion: nil)
    }
    .disposed(by: self.disposeBag)
  }
  
  // MARK: - Constraints
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.addSubview(self.todayView)
    self.todayView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
    }
  }
}

