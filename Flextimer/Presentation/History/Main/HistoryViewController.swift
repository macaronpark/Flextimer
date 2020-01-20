//
//  HistoryViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/10.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class HistoryViewController: BaseViewController {
  
  var historyViewModel: HistoryViewModel?
  
  lazy var createRecordBarButton = UIBarButtonItem(
    image: UIImage(named: "history_add"),
    style: .plain,
    target: self,
    action: nil
  )
  
  let dateCheckView = HistoryDateCheckView()
  
  lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
    $0.delegate = self
    $0.dataSource = self
    $0.register(HistoryTableViewCell.self)
  }
  
  
  // MARK: - Init
  
  convenience init(_ viewModel: HistoryViewModel) {
    self.init()
    
    self.historyViewModel = viewModel
  }
  
  
  // MARK: - Lifecycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // scroll to today record cell
    let monday = Date().getThisWeekMonday()
    let weekOfMonthComponent = Calendar.current.dateComponents([.weekOfMonth], from: monday)
    let thisWeekSection = (weekOfMonthComponent.weekOfMonth ?? 0) - 1
    DispatchQueue.main.async {
      self.tableView.scrollToRow(at: IndexPath(row: 0, section: thisWeekSection), at: .top, animated: true)
    }
  }
  
  override func setupNaviBar() {
    super.setupNaviBar()
    
    self.title = "기록"
    self.navigationItem.largeTitleDisplayMode = .automatic
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationItem.rightBarButtonItem = self.createRecordBarButton
  }
  
  override func bind() {
    super.bind()
    
    self.dateCheckView.currentYearMonthButton.rx.tap.bind { _ in
      let vc = CalendarViewController()
      vc.modalPresentationStyle = .overFullScreen
      vc.modalTransitionStyle = .crossDissolve
      self.present(vc, animated: true, completion: nil)
    }.disposed(by: self.disposeBag)
  }
  
  
  // MARK: - Setup constraints
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.addSubview(self.dateCheckView)
    self.view.addSubview(self.tableView)
    
    self.dateCheckView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(56)
    }
    self.tableView.snp.makeConstraints {
      $0.top.equalTo(self.dateCheckView.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  
  // MARK: - Custom Methods
  
  func allDatesIn(month: Int, year: Int) -> [Date] {
    let startDateComponents = DateComponents(year: year, month: month, day: 1)
    let endDateComponents = DateComponents(year: year, month: month + 1, day: 0)
    
    guard let startDate = Calendar.current.date(from: startDateComponents),
      let endDate = Calendar.current.date(from: endDateComponents),
      startDate < endDate else { return [Date]() }
    
    var tempDate = startDate
    var dates = [tempDate]
    
    while tempDate < endDate {
      tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
      dates.append(tempDate)
    }
    
    return dates
  }
}
