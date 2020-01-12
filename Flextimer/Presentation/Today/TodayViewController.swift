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
  
//  var timer : Timer?
  var timer: Observable<Int>?
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
      .map { $0 }
      .bind { [weak self] isWorking in
        guard let self = self else { return }
        if isWorking {
          self.timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        }
    }.disposed(by: self.disposeBag)
    
    self.timer?
      .map { _ in Date().timeIntervalSince(self.todayViewModel.workRecordOfToday?.startDate ?? Date()).rounded() }
      .bind(to: self.todayView.stackView.rx.updateRemainTime)
      .disposed(by: self.disposeBag)
    
    self.timer?
      .map { _ in Date().timeIntervalSince(self.todayViewModel.workRecordOfToday?.startDate ?? Date()).rounded() }
      .bind(to: self.todayView.timerView.rx.viewModel)
      .disposed(by: self.disposeBag)
    
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

     
  }
  
//  @objc func timerCallBack() {
//    let interval = Date().timeIntervalSince(self.todayViewModel.workRecordOfToday?.startDate ?? Date()).rounded()
//    self.todayView.timerView.updateUI(interval.toString(.total))
    
    
//     if let startDate = self.userData.startDate {
    //      // 총 근무 시간 업데이트
    //      let interval = output.timeIntervalSince(startDate).rounded()
    //      self.userData.ingTimeInterval = interval
    //      self.currentTime = interval.toString(.total)
    //      // 남은 근무 시간(픽스 근무 시간 - 총 근무 시간) 업데이트
    //      let workingHoursInterval = (self.userData.workingHours.value + 1).toRoundedTimeInterval()
    //      let remainInterval = workingHoursInterval - interval
    //
    //        if remainInterval.isLess(than: 0.0) {
    //            self.userData.remainTime = (-remainInterval).toString(.remain) + "째 초과근무 중"
    //        } else {
    //            self.userData.remainTime = remainInterval.toString(.remain) + " 남았어요"
    //        }
//  }
  
  func showStartAlert() {
    
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
