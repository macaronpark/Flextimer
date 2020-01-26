//
//  SettingViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {
  
  
  lazy var viewModel = SettingViewModel(RealmService.shared.userInfo)
  let closeBarButton = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: nil)
  
  lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
    $0.delegate = self
    $0.dataSource = self
    $0.backgroundColor = .clear
    $0.register(SettingDayNameCell.self)
    $0.register(SettingCell.self)
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.addSubview(self.tableView)
    self.tableView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.registerNotification()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.bindStackViewButtons()
  }

  override func setupNaviBar() {
    super.setupNaviBar()
    
    self.title = "설정"
    self.navigationItem.leftBarButtonItem = self.closeBarButton
  }
  
  // MARK: - Notification
  
  func registerNotification() {
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
  
  @objc func didUpdateWorkhousNotification(_ notification: NSNotification) {
    let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SettingCell
    cell?.updateWorkhoursUI(RealmService.shared.userInfo)
  }
  
  override func bind() {
    super.bind()
    
    self.closeBarButton.rx.tap
      .bind {[weak self] in self?.dismiss(animated: true, completion: nil) }
      .disposed(by: self.disposeBag)
  }
}
