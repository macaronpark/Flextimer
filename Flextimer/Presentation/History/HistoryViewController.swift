//
//  HistoryViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/10.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryViewController: BaseViewController {
  
  lazy var createRecordBarButton = UIBarButtonItem(
    barButtonSystemItem: .add,
    target: self,
    action: nil
  )
  
  let dateCheckView = HistoryDateCheckView()
  
  lazy var tableView = UITableView(frame: .zero, style: .plain).then {
    $0.delegate = self
    $0.dataSource = self
    $0.backgroundColor = .clear
    $0.register(HistoryTableViewCell.self)
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.addSubview(self.dateCheckView)
    self.view.addSubview(self.tableView)
    
    self.dateCheckView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
    }
    self.tableView.snp.makeConstraints {
      $0.top.equalTo(self.dateCheckView.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  override func setupNaviBar() {
    super.setupNaviBar()
    
    self.title = "기록"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationItem.rightBarButtonItem = self.createRecordBarButton
  }
  
  
}
