//
//  HistoryDetailViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/21.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryDetailViewController: BaseViewController {
  
  var workRecord: WorkRecord?
  
  lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
    $0.delegate = self
    $0.dataSource = self
    $0.register(HistoryDetailTableViewCell.self)
    $0.register(HistoryDetailDeleteTableViewCell.self)
  }
  
  init(_ workRecord: WorkRecord) {
    super.init()
    
    self.workRecord = workRecord
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func setupNaviBar() {
    super.setupNaviBar()
    
    self.title = Formatter.dayName.string(from: self.workRecord?.startDate ?? Date())
    self.navigationItem.largeTitleDisplayMode = .automatic
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.addSubview(self.tableView)
    self.tableView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}
