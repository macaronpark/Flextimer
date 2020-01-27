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
  
  let todayView = TodayView()
  
  var todayViewModel: TodayViewModel!
  
  let isWorking = BehaviorRelay(value: false)
  
  var workRecordNotificationToken: NotificationToken? = nil
  
  var userInfoNotificationToken: NotificationToken? = nil
  
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
    
    // TODO: viewModel 기준으로 rx 로직 변경하기
    self.todayViewModel = viewModel
    self.isWorking.accept(viewModel.isWorking)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Lifecycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupUserInfoNotification()
    self.setupWorkRecordNotification()
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

    let share = self.isWorking
    
    share
      .bind(to: self.todayView.buttonsView.rx.viewModel)
      .disposed(by: self.disposeBag)
    
    share
      .bind { [weak self] _ in
        guard let self = self else { return }
        self.todayView.optionView.rx.viewModel.onNext(self.todayViewModel)
    }.disposed(by: self.disposeBag)
    
    share
      .bind { [weak self] isWorking in
        guard let self = self else { return }
        if (isWorking == false) {
          // 위젯 퇴근 -> 히스토리에서 기록 삭제 시 터짐 방지
          self.todayViewModel.workRecordOfToday = nil
        }
        self.todayView.stackView.rx.viewModel.onNext((self.todayViewModel, isWorking))
    }.disposed(by: self.disposeBag)
    
    share
      .filter { $0 == false }
      .bind(to: self.todayView.timerView.rx.resetTimer)
      .disposed(by: disposeBag)

    share
      .flatMapLatest { $0 ? Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance): .empty() }
      .bind { [weak self] _ in
        guard let self = self else { return }
        self.todayView.timerView.rx.viewModel.onNext(self.todayViewModel)
    }.disposed(by: disposeBag)
    
    self.todayView.buttonsView.startButton.rx.tap
      .bind(onNext: { [weak self] in self?.didTapStartButton() })
      .disposed(by: self.disposeBag)
    
    self.todayView.buttonsView.endButton.rx.tap
      .bind(onNext: { [weak self] in self?.showEndAlert() })
      .disposed(by: self.disposeBag)
    
    self.isWorking
      .bind(to: self.todayView.stackView.startCellButton.rx.isUserInteractionEnabled)
      .disposed(by: self.disposeBag)
    
    // TODO: 탭 시 출근시간 변경할 수 있게
    self.todayView.stackView.startCellButton.rx.tap
      .flatMapLatest { [weak self] _ -> Observable<Date> in
        return DatePickerViewController.date(
          parent: self,
          current: self?.todayViewModel.workRecordOfToday?.startDate ?? Date(),
          max: Date(),
          mode: .time,
          doneButtonTitle: "기록 변경"
        ).skip(1)
    }.subscribe(onNext: { [weak self] date in
      if let workRecord = self?.todayViewModel.workRecordOfToday {
        RealmService.shared.update(workRecord, with: ["startDate": date])
        self?.isWorking.accept(true)
      }
    }).disposed(by: self.disposeBag)
    
    self.settingBarButton.rx.tap
      .map { UINavigationController(rootViewController: SettingViewController()) }
      .bind { [weak self] in
        self?.navigationController?.present($0, animated: true, completion: nil)
    }.disposed(by: self.disposeBag)
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
