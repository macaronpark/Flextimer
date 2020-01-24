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
    $0.contentInset.top = 56
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
    
    self.scrollToCurrentWeek()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.tableView.reloadData()
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
    
    self.dateCheckView.currentYearMonthButton.rx.tap
      .flatMapLatest { [weak self] _ -> Observable<Date> in
        return DatePickerViewController.date(
          parent: self,
          current: Date(),
          mode: .date,
          doneButtonTitle: "기록 조회"
        ).skip(1)
    }.subscribe(onNext: { [weak self] date in
      guard let self = self else { return }
      
      self.historyViewModel = HistoryViewModel(year: date.year, month: date.month)
      self.dateCheckView.currentYearMonthButton.setTitle("\(date.year)년 \(date.month)월", for: .normal)
      
      DispatchQueue.main.async { [weak self] in
             guard let self = self else { return }
        self.tableView.reloadData()
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
      }
    }).disposed(by: self.disposeBag)
    
    self.dateCheckView.todayButton.rx.tap
      .bind { [weak self] in
        let comp = Calendar.current.dateComponents([.year, .month], from: Date())
        if let year = comp.year,
          let month = comp.month {
          self?.dateCheckView.currentYearMonthButton.setTitle("\(year)년 \(month)월", for: .normal)
          self?.historyViewModel = HistoryViewModel(year: year, month: month)
          
          DispatchQueue.main.async {
            self?.tableView.reloadData()
            self?.scrollToCurrentWeek()
          }
        }
    }.disposed(by: self.disposeBag)
  }
  
  
  // MARK: - Setup constraints
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.addSubview(self.tableView)
    self.view.addSubview(self.dateCheckView)
    
    self.dateCheckView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(56)
    }
    self.tableView.snp.makeConstraints {
      $0.top.equalTo(self.view.snp.top)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  
  // MARK: - Custom Methods
  
  func scrollToCurrentWeek() {
    let monday = Date().getThisWeekMonday()
    let weekOfMonthComponent = Calendar.current.dateComponents([.weekOfMonth], from: monday)
    let thisWeekSection = (weekOfMonthComponent.weekOfMonth ?? 0) - 1
    DispatchQueue.main.async {
      self.tableView.scrollToRow(at: IndexPath(row: 0, section: thisWeekSection), at: .top, animated: true)
    }
  }
}
