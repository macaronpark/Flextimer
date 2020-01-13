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
//  var timer: Observable<Int>?
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
    
    let isWorking = Observable
      .of(self.todayViewModel.isWorking)
      .asObservable()
    
    isWorking
      .map { !$0 }
      .bind(to: self.todayView.buttonsView.startButton.rx.isEnabled)
      .disposed(by: self.disposeBag)
    
    isWorking
      .map { $0 }
      .bind(to: self.todayView.buttonsView.endButton.rx.isEnabled)
      .disposed(by: self.disposeBag)
    
    isWorking
      .bind(to: self.isWorking).disposed(by: self.disposeBag)
    //    isWorking
    //      .map { $0 }
    //      .bind { [weak self] isWorking in
    //        guard let self = self else { return }
    //        if isWorking {
    //          self.timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
    //        }
    //    }.disposed(by: self.disposeBag)
    
    isWorking.asObservable()
      .debug("isRunning")
      .flatMapLatest {  isRunning in
        isRunning ? Observable<Int>.interval(1, scheduler: MainScheduler.instance) : .empty()
    }
//    .enumerated()
//    .flatMap { (int, index) in Observable.just(index) }
      .map { _ in Date().timeIntervalSince(self.todayViewModel.workRecordOfToday?.startDate ?? Date()).rounded() }
      
      .bind { itv in
        self.todayView.stackView.rx.updateRemainTime.onNext(itv)
        self.todayView.timerView.rx.viewModel.onNext(itv)
    }
//    .subscribe()
    .disposed(by: disposeBag)
    
    //    self.timer?
    //      .map { _ in Date().timeIntervalSince(self.todayViewModel.workRecordOfToday?.startDate ?? Date()).rounded() }
    //      .do(onNext: { print($0, "1")} )
    //      .filter { $0 != 0 }
    //      .bind(to: self.todayView.stackView.rx.updateRemainTime)
    //      .disposed(by: self.disposeBag)
    //
    //    self.timer?
    //      .map { _ in Date().timeIntervalSince(self.todayViewModel.workRecordOfToday?.startDate ?? Date()).rounded() }
    //      .do(onNext: { print($0, "2")} )
    //      .filter { $0 != 0 }
    //      .bind(to: self.todayView.timerView.rx.viewModel)
    //      .disposed(by: self.disposeBag)
    
    self.todayView.optionView.rx.viewModel.onNext(self.todayViewModel)
    self.todayView.stackView.rx.viewModel.onNext(self.todayViewModel)
    
    self.settingBarButton.rx.tap
      .map { UINavigationController(rootViewController: SettingViewController()) }
      .bind { [weak self] in
        self?.navigationController?.present($0, animated: true, completion: nil)
    }
    .disposed(by: self.disposeBag)
    
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

