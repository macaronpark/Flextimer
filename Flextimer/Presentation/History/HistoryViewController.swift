//
//  HistoryViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/10.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryViewController: BaseViewController {
  
  var allDatesInMonth = [Date]()
  var viewModels = [HistoryViewModel]()
  
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
  
  
  // MARK: - Init
  
  override init() {
    super.init()

    let comp = Calendar.current.dateComponents([.year, .month], from: Date())
    self.allDatesInMonth = self.allDatesIn(month: comp.month ?? 0, year: comp.year ?? 0)
    self.viewModels = self.allDatesInMonth.map { HistoryViewModel($0) }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Lifecycles
  
  override func setupNaviBar() {
    super.setupNaviBar()
    
    self.title = "기록"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationItem.rightBarButtonItem = self.createRecordBarButton
  }
  
  override func bind() {
    super.bind()
    
    
  }
  
  
  // MARK: - Setup constraints
  
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
