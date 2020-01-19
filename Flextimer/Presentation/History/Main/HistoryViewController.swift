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
  
  convenience init(_ cellModels: [HistoryCellModel]) {
    self.init()
    
    var sections = [HistroySectionModel]()
    var tempCell = cellModels
    
    // 1: 셀모델을 주단위로 쪼갠다
    let weekRange = Calendar.current.range(of: .weekOfMonth, in: .month, for: Date())!
    
    let _ = weekRange.map { weekIdx in
      // 첫 째 주의 weekday 수집 (디폴트로 토요일까지 수집 됨)
      var weekdays = tempCell.filter {
        Calendar.current.date($0.date, matchesComponents: DateComponents(weekOfMonth: weekIdx))
      }
      
      // 마지막 주의 경우 남은 날짜를
      if (weekIdx == weekRange.count) {
        let section = HistroySectionModel(weekdays)
        sections.append(section)
        return
      }
      
      // 일요일 추가 수집
      weekdays.append(tempCell[weekdays.count])
      
      // 주 모델 반환
      let section = HistroySectionModel(weekdays)
      sections.append(section)
      
      // 반환된 날짜 지우기 (일요일도 포함되서 삭제되므로 둘째 주부터는 월요일부터 계산된다)
      tempCell.removeSubrange(0..<weekdays.count)
    }
    
    // 2: 주단위를 섹션모델로 만든다
    // 3: 만들어진 섹션모델들로 뷰모델을 만든다
    let viewModel = HistoryViewModel(sections)
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
