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
      .flatMapLatest { $0 ? Observable<Int>.interval(1, scheduler: MainScheduler.instance): .empty() }
      .map { _ in self.todayViewModel }
      .bind(to: self.todayView.timerView.rx.viewModel)
      .disposed(by: disposeBag)
    
    let workRecordInToday = RealmService.shared.realm
      .objects(WorkRecord.self)
      .filter { Calendar.current.isDateInToday($0.startDate) }
      .last
    
    self.todayView.buttonsView.startButton.rx.tap
      .map { (workRecordInToday != nil) ? true: false }
      .bind { [weak self] isTodayRecord in
        guard let self = self else { return }
        if isTodayRecord {
          self.showStartAlert()
        } else {
          let newWorkRecord = WorkRecord(Date())
          RealmService.shared.create(newWorkRecord)
        }
    }.disposed(by: self.disposeBag)
    
    self.todayView.buttonsView.endButton.rx.tap
      .bind(onNext: { self.showEndAlert() })
      .disposed(by: self.disposeBag)
    
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

