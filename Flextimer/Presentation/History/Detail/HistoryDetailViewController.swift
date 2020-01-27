//
//  HistoryDetailViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/21.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RealmSwift

class HistoryDetailViewController: BaseViewController {
  
  var workRecord: WorkRecord?
  var notificationToken: NotificationToken?
  var viewModel: HistoryDetailViewModel?
  
  lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
    $0.delegate = self
    $0.dataSource = self
    $0.register(HistoryDetailTableViewCell.self)
  }
  
  init(_ workRecord: WorkRecord) {
    super.init()
    
    self.workRecord = workRecord
    self.viewModel = HistoryDetailViewModel(workRecord)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.addRealmNoti()
  }
  
  func addRealmNoti() {
    self.notificationToken = self.workRecord?.observe() { [weak self] change in
      guard let self = self else { return }
      
      switch change {
      case .change(_):
        self.viewModel = HistoryDetailViewModel(self.workRecord ?? WorkRecord())
        self.tableView.reloadData()

      default: break
      }
    }
  }
  
  override func setupNaviBar() {
    super.setupNaviBar()
    
    self.title = Formatter.dayName.string(from: self.workRecord?.startDate ?? Date())
    self.navigationController?.navigationBar.tintColor = Color.immutableOrange
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.addSubview(self.tableView)
    self.tableView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  //  // MARK: - Notification
  //
  //  func registerNotification() {
  //    NotificationCenter.default.addObserver(
  //      self, selector: #selector(didUpdateWorkhourNotification(_:)),
  //      name: RNotiKey.didUpdateWorkhour,
  //      object: WorkRecord.self
  //    )
  //  }
  //
  //  @objc func didUpdateWorkhourNotification(_ notification: NSNotification) {
  //    DispatchQueue.main.async {
  //      self.tableView.reloadData()
  //    }
  //  }
}
