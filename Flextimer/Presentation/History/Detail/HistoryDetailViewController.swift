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
    $0.register(HistoryDetailMemoTableViewCell.self)
    $0.estimatedRowHeight = 44
    $0.rowHeight = UITableView.automaticDimension
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
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
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
  
  @objc func keyboardWillShow(_ notification: Notification) {
    guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    
    DispatchQueue.main.async {
      self.tableView.snp.updateConstraints {
        $0.bottom.equalToSuperview().offset(-keyboardFrame.cgRectValue.height)
      }
    }
    
    let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? HistoryDetailMemoTableViewCell
    if let cell = cell {
      cell.memoTextView.rx.didChange.subscribe { [weak self] _ in
        self?.tableView.beginUpdates()
        
        
//        DispatchQueue.main.async {
//          self?.tableView.scrollRectToVisible(cell.frame, animated: true)
//        }
        
        self?.tableView.endUpdates()
        
        
        
      }.disposed(by: self.disposeBag)
    }
  }
}
