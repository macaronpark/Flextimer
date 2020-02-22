//
//  SettingViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RealmSwift

class SettingViewController: BaseViewController {
  
  enum Text {
    static let SVC_SETTINGS = "SVC_SETTINGS".localized
    static let SVC_SECTION1 = "SVC_SECTION1".localized
    static let SVC_SECTION2 = "SVC_SECTION2".localized
    static let SVC_SECTION3 = "SVC_SECTION3".localized
  }
  
  var impactGenerator: UIImpactFeedbackGenerator?
  
  var userInfoNotificationToken: NotificationToken?
  
  lazy var viewModel = SettingViewModel(RealmService.shared.userInfo)
  
  let closeBarButton = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: nil)
  
  lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
    $0.delegate = self
    $0.dataSource = self
    $0.backgroundColor = .clear
    $0.register(SettingDayNameCell.self)
    $0.register(SettingCell.self)
  }
  
  deinit {
    self.userInfoNotificationToken?.invalidate()
  }
  
  
  // MARK: - Lifecycles

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.bindStackViewButtons()
    self.setupUserInfoNotification()
    self.impactGenerator = UIImpactFeedbackGenerator(style: .medium)
  }

  func setupUserInfoNotification() {
    let results = RealmService.shared.realm.objects(UserInfo.self)
    self.userInfoNotificationToken = results.observe { [weak self] changes in
      guard let self = self else { return }
      
      switch changes {
      case .update:
        let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SettingCell
        cell?.updateWorkhoursUI(RealmService.shared.userInfo)
        
      default:
        break
      }
    }
  }

  override func setupNaviBar() {
    super.setupNaviBar()
    
    self.title = Text.SVC_SETTINGS
    self.navigationItem.leftBarButtonItem = self.closeBarButton
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.addSubview(self.tableView)
    self.tableView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  override func bind() {
    super.bind()
    
    self.closeBarButton.rx.tap
      .bind { [weak self] in self?.dismiss(animated: true, completion: nil) }
      .disposed(by: self.disposeBag)
  }
  
  func triggerImpact() {
    self.impactGenerator?.impactOccurred()
  }
}
