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
import RealmSwift

class HistoryViewController: BaseViewController {
  
  var displayedDate = BehaviorRelay<Date>(value: Date())
  
  var willScrollToSelectedDate = PublishSubject<Bool>()
  
  var workRecordnotificationToken: NotificationToken? = nil
  
  var userInfoNotificationToken: NotificationToken? = nil
  
  var impactGenerator: UIImpactFeedbackGenerator?
  
  var historyViewModel: HistoryViewModel?
  
  let dateCheckView = HistoryDateCheckView()
  
  lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
    $0.contentInset.top = 60
    $0.delegate = self
    $0.dataSource = self
    $0.register(HistoryTableViewCell.self)
    $0.register(
      HistorySectionFooterView.self,
      forHeaderFooterViewReuseIdentifier: "HistorySectionFooterView"
    )
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
    
    self.willScrollToSelectedDate.onNext(true)
    self.setupNotifications()
  }
  
  func setupNotifications() {
    // system
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(willEnterForeground),
      name: UIApplication.willEnterForegroundNotification,
      object: nil
    )
    
    // realm
    self.setupWorkRecordNotification()
    self.setupUserInfoNotification()
  }
  
  @objc func willEnterForeground() {
    self.tableView.reloadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.tableView.reloadData()
  }
  
  override func setupNaviBar() {
    super.setupNaviBar()
    
    self.title = "기록"
    self.navigationController?.navigationBar.tintColor = UIColor.systemFill
    self.navigationItem.largeTitleDisplayMode = .automatic
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  override func bind() {
    super.bind()
    
    let displayedDate = self.displayedDate.asObservable()
      
    displayedDate
      .map { (HistoryViewModel(year: $0.year, month: $0.month), $0) }
      .subscribe(onNext: { [weak self] (model, date) in
        self?.historyViewModel = model
        self?.tableView.reloadData()
      }).disposed(by: self.disposeBag)
    
    displayedDate
      .map {"\($0.year)년 \($0.month)월" }
      .bind(to: self.dateCheckView.currentYearMonthButton.rx.title(for: .normal))
      .disposed(by: self.disposeBag)

    self.willScrollToSelectedDate
      .map { [weak self] _ in self?.displayedDate.value ?? Date() }
      .bind(onNext: { [weak self] in self?.scrollTo(date: $0) })
      .disposed(by: self.disposeBag)

    self.dateCheckView.currentYearMonthButton.rx.tap
      .flatMapLatest { [weak self] _ -> Observable<Date> in
        return DatePickerViewController.date(
          parent: self,
          current: self?.displayedDate.value ?? Date(),
          mode: .date,
          doneButtonTitle: "기록 조회"
        ).skip(1)
    }.bind { [weak self] date in
      self?.displayedDate.accept(date)
      self?.willScrollToSelectedDate.onNext(true)
    }
    .disposed(by: self.disposeBag)

    self.dateCheckView.todayButton.rx.tap
      .map { Date() }
      .bind { [weak self] date in
        self?.displayedDate.accept(date)
        self?.willScrollToSelectedDate.onNext(true)
    }.disposed(by: self.disposeBag)
    
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
      $0.height.equalTo(60)
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
  
  func setupWorkRecordNotification() {
    // TODO: realm queries month...?
    let results = RealmService.shared.realm.objects(WorkRecord.self)
    // .filter { Calendar.current.compare($0.startDate, to: self.displayedDate.value, toGranularity: .month) == ComparisonResult.orderedSame }
    self.workRecordnotificationToken = results.observe { [weak self] changes in
      switch changes {
      case .update:
        let value = self?.displayedDate.value ?? Date()
        self?.displayedDate.accept(value)
        
      default:
        break
      }
    }
  }
  
  func setupUserInfoNotification() {
    let results = RealmService.shared.realm.objects(UserInfo.self)
    
    self.userInfoNotificationToken = results.observe { [weak self] changes in
      switch changes {
      case .update:
        let value = self?.displayedDate.value ?? Date()
        self?.displayedDate.accept(value)
        
      default:
        break
      }
    }
  }
}
