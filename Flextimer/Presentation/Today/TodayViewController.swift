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
  
  
  // MARK: - Notification
  
  func registerNotification() {
    NotificationCenter.default.addObserver(
      self, selector: #selector(didUpdateOptionsNotification(_:)),
      name: NSNotification.Name.didUpdateOptions,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self, selector: #selector(didUpdateWorkhousNotification(_:)),
      name: RNotiKey.didUpdateHourOfWorkhoursADay,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self, selector: #selector(didUpdateWorkhousNotification(_:)),
      name: RNotiKey.didUpdateMinuteOfWorkhoursADay,
      object: nil
    )
  }
  
  @objc func didUpdateOptionsNotification(_ notification: NSNotification) {
    //    let realm = try! Realm()
    //      datasource = realm.objects(AnObject.self)
    //      tableView.reloadData()
    self.todayView.optionView.rx.viewModel.onNext(self.todayViewModel)
  }
  
  @objc func didUpdateWorkhousNotification(_ notification: NSNotification) {
    self.todayView.optionView.rx.viewModel.onNext(self.todayViewModel)
//    cell?.updateWorkhoursUI(RealmService.shared.userInfo)
  }
  
  
  // MARK: - Bind
  
  override func bind() {
    super.bind()
    
    self.settingBarButton.rx.tap
      .map { UINavigationController(rootViewController: SettingViewController()) }
      .bind { [weak self] in
        self?.navigationController?.present($0, animated: true, completion: nil)
    }
    .disposed(by: self.disposeBag)
    
    self.todayView.optionView.rx.viewModel
      .onNext(self.todayViewModel)
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
