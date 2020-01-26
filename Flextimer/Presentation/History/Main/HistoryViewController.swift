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
  
  var impactGenerator: UIImpactFeedbackGenerator?
  
  var displayedDate = BehaviorRelay<Date>(value: Date())
  
  lazy var createRecordBarButton = UIBarButtonItem(
    image: UIImage(systemName: "info.circle"),
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
    self.impactGenerator = UIImpactFeedbackGenerator(style: .medium)
  }
  
  
  // MARK: - Lifecycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
    
    let displayedDate = self.displayedDate.asObservable()
      
    displayedDate
      .debug("🔥set displayedDate")
      .subscribe(onNext: { [weak self] date in
        self?.tableView.reloadData()
        self?.scrollTo(date: date)
    }).disposed(by: self.disposeBag)
    
    displayedDate
      .map { HistoryViewModel(year: $0.year, month: $0.month) }
      .subscribe(onNext: { [weak self] in
        self?.historyViewModel = $0
      }).disposed(by: self.disposeBag)
    
    displayedDate
      .map {"\($0.year)년 \($0.month)월" }
      .bind(to: self.dateCheckView.currentYearMonthButton.rx.title(for: .normal))
      .disposed(by: self.disposeBag)

    self.dateCheckView.currentYearMonthButton.rx.tap
      .flatMapLatest { [weak self] _ -> Observable<Date> in
        return DatePickerViewController.date(
          parent: self,
          current: self?.displayedDate.value ?? Date(),
          mode: .date,
          doneButtonTitle: "기록 조회"
        ).skip(1)
    }.map { $0 }
    .bind(to: self.displayedDate)
    .disposed(by: self.disposeBag)

    self.dateCheckView.todayButton.rx.tap
      .map { Date() }
      .bind(to: self.displayedDate)
      .disposed(by: self.disposeBag)
    
    self.dateCheckView.todayButton.rx.tap
      .bind(onNext: { [weak self] in self?.triggerImpact() })
      .disposed(by: self.disposeBag)
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
  
  func scrollTo(date: Date) {
    let monday = date.getMonday(date)
    let sectionIndex = self.historyViewModel?.sections
      .firstIndex(where: {
        $0.rows.contains(where: { Calendar.current.isDate($0.date, inSameDayAs: monday)})
      }) ?? 0

    DispatchQueue.main.async {
      self.tableView.scrollToRow(
        at: IndexPath(row: 0, section: sectionIndex),
        at: .top,
        animated: true
      )
    }
  }
  
  private func triggerImpact() {
    self.impactGenerator?.impactOccurred()
  }
}
