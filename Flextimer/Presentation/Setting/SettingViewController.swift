//
//  SettingViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {
  
  lazy var viewModel = SettingViewModel()
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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.bindStackViewButtons()
  }
  
  override func setupNaviBar() {
    super.setupNaviBar()
    
    self.title = "설정"
    self.navigationItem.leftBarButtonItem = self.closeBarButton
  }
  
  override func bind() {
    super.bind()
    
    self.closeBarButton.rx.tap
      .bind { self.dismiss(animated: true, completion: nil) }
      .disposed(by: self.disposeBag)
  }
}
