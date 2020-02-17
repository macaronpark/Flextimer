//
//  TodayViewController.swift
//  Widget
//
//  Created by Suzy Mararon Park on 2019/10/17.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import UIKit
import NotificationCenter

import RealmSwift
import RxCocoa
import RxSwift

class TodayViewController: UIViewController, NCWidgetProviding {
  
  @IBOutlet weak var startButton: WidgetButton!
  
  @IBOutlet weak var endButton: WidgetButton!
  
  @IBOutlet weak var startTimeLabel: UILabel!
  
  @IBOutlet weak var remainTimeLabel: UILabel!
  
  @IBOutlet weak var alertLabel: UILabel!
  
  var isWorking = BehaviorRelay<Bool>(value: false)
  
  var descriptionString = BehaviorRelay<String>(value: "")
  
  let disposeBag = DisposeBag()
  
  
  // MARK: - Lifecycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupRealm()
    self.setupUI()
    
    // Rx
    let todayRecord = RealmService.shared.realm
      .objects(WorkRecord.self)
      .filter { (Calendar.current.isDate($0.startDate, inSameDayAs: Date()) && $0.endDate == nil) }
      .last
    
    self.isWorking.accept((todayRecord != nil ? true: false))
    self.descriptionString.accept((todayRecord != nil) ? "": "'출근'버튼을 누르면 기록이 시작됩니다")
    self.bind()
  }
  
  fileprivate func setupUI() {
    self.startButton.setBasicConfig(.start)
    self.endButton.setBasicConfig(.end)
    self.startTimeLabel.textColor = Color.secondaryText
    self.remainTimeLabel.textColor = Color.primaryText
  }
  
  fileprivate func bind() {
    let share = self.isWorking
    
    share
      .map { !$0 }
      .bind(to: self.startButton.rx.isEnabled)
      .disposed(by: self.disposeBag)
    
    share
      .bind(to: self.endButton.rx.isEnabled)
      .disposed(by: self.disposeBag)
    
    share
      .map { !$0 }
      .bind(to: self.startTimeLabel.rx.isHidden)
      .disposed(by: self.disposeBag)
    
    share
      .map { !$0 }
      .bind(to: self.remainTimeLabel.rx.isHidden)
      .disposed(by: self.disposeBag)
    
    share
      .bind(to: self.alertLabel.rx.isHidden)
      .disposed(by: self.disposeBag)
    
    share
      .flatMapLatest { $0 ? Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance): .empty() }
      .bind(onNext: { [weak self] _ in self?.setupTimeLabels()})
      .disposed(by: disposeBag)
    
    self.descriptionString
      .map { $0.count < 0 }
      .bind(to: self.alertLabel.rx.isHidden)
      .disposed(by: self.disposeBag)
    
    self.descriptionString
      .bind(to: self.alertLabel.rx.text)
      .disposed(by: self.disposeBag)
    
    self.startButton.rx.tap.map { _ -> Bool in
      let records = RealmService.shared.realm
        .objects(WorkRecord.self)
        .filter { (Calendar.current.isDate($0.startDate, inSameDayAs: Date())) }
      return (records.count > 0)
    }.bind { [weak self] isTodayRecordExist in
      if (isTodayRecordExist == true) {
        self?.alertLabel.textColor = .red
        self?.descriptionString.accept("이미 출근한 기록이 있네요. 앱에서 확인 해 주세요.")
      } else {
        let newRecord = WorkRecord(Date())
        RealmService.shared.create(newRecord)
        self?.isWorking.accept(true)
      }
    }.disposed(by: self.disposeBag)
    
    self.endButton.rx.tap.map { _ -> WorkRecord? in
      let record = RealmService.shared.realm
        .objects(WorkRecord.self)
        .filter { (Calendar.current.isDate($0.startDate, inSameDayAs: Date()) && $0.endDate == nil) }
        .last
      return record
    }.bind { [weak self] workRecord in
      if let workRecord = workRecord {
        RealmService.shared.update(workRecord, with: ["endDate": Date()])
        self?.isWorking.accept(false)
        self?.descriptionString.accept("오늘 하루도 멋졌던 당신😎, 떠나요 집으로!🌴🛁🧡")
      }
    }.disposed(by: self.disposeBag)
  }
  
  
  // MARK: - Realm
  
  fileprivate func setupRealm() {
    let fileURL = FileManager.default
      .containerURL(forSecurityApplicationGroupIdentifier: "group.suzypark.Flextimer")!
      .appendingPathComponent("shared.realm")
    
    // schemaVersion 5: UserInfo-isTutorialSeen property 추가
    // schemaVersion 6: WorkRecord -> memo: String property 추가
    let config = Realm.Configuration(
      fileURL: fileURL,
      schemaVersion: 6,
      migrationBlock: { migration, oldSchemaVersion in
        if (oldSchemaVersion < 6) {
          migration.enumerateObjects(ofType: WorkRecord.className()) { oldObject, newObject in
            newObject!["memo"] = nil
          }
        }
    })
    
    Realm.Configuration.defaultConfiguration = config
  }
  
  
  // MARK: - Custom Methods
  
  func setupTimeLabels() {
    let record = RealmService.shared.realm
      .objects(WorkRecord.self)
      .filter { (Calendar.current.isDate($0.startDate, inSameDayAs: Date()) && $0.endDate == nil) }
      .last
    
    if let record = record {
      self.startTimeLabel.text = "출근: \(Formatter.shm.string(from: record.startDate))"
      
      let isLessRemainsThanWorkhoursADay = self.isLessRemainsThanWorkhoursADay()
      
      let h = RealmService.shared.userInfo.hourOfWorkhoursADay.toRoundedTimeInterval(.hour)
      let m = RealmService.shared.userInfo.minuteOfWorkhoursADay.toRoundedTimeInterval(.minute)
      let totalWorkHourInterval = h + m
      
      if isLessRemainsThanWorkhoursADay.isLessRemains {
        
        if let remains = isLessRemainsThanWorkhoursADay.raminsInterval {
          if remains > 0 {
            self.remainTimeLabel.text = "퇴근까지 " + remains.toString(.remain) + " 남았어요"
          } else if remains.isZero {
            self.remainTimeLabel.text = totalWorkHourInterval.toString(.remain) + " 클리어!"
          } else {
            self.remainTimeLabel.text = "🚨초과 근무 경보🚨 " + (-remains).toString(.remain) + " 째 초과근무 중"
          }
        }
      } else {
        self.remainTimeLabel.text = "퇴근까지 \(self.remains(from: record.startDate))"
      }
    }
  }
    
  func remains(from date: Date?) -> String {
    guard let date = date else { return "--:--" }
    
    let interval = Date().timeIntervalSince(date).rounded()
    // 남은 시간: 일일 근무 시간 - interval
    let h = RealmService.shared.userInfo.hourOfWorkhoursADay.toRoundedTimeInterval(.hour)
    let m = RealmService.shared.userInfo.minuteOfWorkhoursADay.toRoundedTimeInterval(.minute)
    let totalWorkHourInterval = h + m
    let remainInterval = totalWorkHourInterval - interval
    
    if remainInterval.isZero {
      return remainInterval.toString(.remain) + " 클리어!"
    } else if remainInterval.isLess(than: 0.0) {
      if (-remainInterval).toString(.remain) == "0시간 0분" {
        return remainInterval.toString(.remain) + " 클리어!"
      }
      return (-remainInterval).toString(.remain) + "째 초과근무 중"
    } else {
      return remainInterval.toString(.remain) + " 남았어요"
    }
  }
  
  func isLessRemainsThanWorkhoursADay(
  ) -> (isLessRemains: Bool, raminsInterval: TimeInterval?) {
    // 지정 근무일 기준 총 근무 시간
    let h = RealmService.shared.userInfo.hourOfWorkhoursADay.toRoundedTimeInterval(.hour)
    let m = RealmService.shared.userInfo.minuteOfWorkhoursADay.toRoundedTimeInterval(.minute)
    let totalWorkhoursInterval = (h + m) * Double(RealmService.shared.userInfo.workdaysPerWeekIdxs.count)

    // 이번 주 토탈 기록
    let monday = Date().getThisWeekMonday()

    var records = [WorkRecord]()
    for i in 0...6 {
      let record = RealmService.shared.realm
        .objects(WorkRecord.self)
        .filter { record in
          let criteriaDate = Calendar.current.date(byAdding: .day, value: i, to: monday) ?? Date()
          if Calendar.current.isDate(record.startDate, inSameDayAs: criteriaDate) && record.endDate != nil {
            return true
          }
          return false
      }.last
      
      if let record = record {
        records.append(record)
      }
    }

    // 실 근무일 수 중 휴일이 아닌 수
    let workdaysRecords = records.filter { $0.isHoliday == false }
    let holidayCount = records.filter { $0.isHoliday == true }.count
    
    let recordsInterval = workdaysRecords
      .map { $0.startDate.timeIntervalSince($0.endDate ?? Date()) }
      .reduce(0, +)

    let recordsIntervalWithHoliday = -recordsInterval + ((h + m) * Double(holidayCount))
    
    // 오늘 시간
    let currentRecordInterval = RealmService.shared.realm
      .objects(WorkRecord.self)
      .filter { Calendar.current.isDate($0.startDate, inSameDayAs: Date()) && $0.endDate == nil }
      .map { $0.startDate.timeIntervalSince($0.endDate ?? Date()) }
      .reduce(0, +)
    
    // 이번주 실 근무 총 인터벌
    let thisWeekWorkhoursTotalInteval = recordsIntervalWithHoliday + (-currentRecordInterval)
    // 남은 시간
    let remains = (totalWorkhoursInterval - thisWeekWorkhoursTotalInteval)

    if remains > (h + m) {
      return (false, nil)
    } else {
      return (true, (remains))
    }
  }
}
