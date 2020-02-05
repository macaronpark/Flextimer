//
//  HistorySectionFooterView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/26.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistorySectionFooterView: UITableViewHeaderFooterView {
  
  let containerView = UIView().then {
    $0.backgroundColor = Color.buttonGray
  }
  
  let criteriaLabel = UILabel().then {
    $0.font = Font.REGURAL_12
    $0.textColor = Color.secondaryText
  }
  
  let totalTimeLabel = UILabel().then {
    $0.font = Font.SEMIBOLD_12
    $0.textColor = Color.secondaryText.withAlphaComponent(0.2)
  }
  
  let remainTimeLabel = UILabel().then {
    $0.font = Font.SEMIBOLD_16
    $0.textColor = Color.immutableOrange
    $0.adjustsFontSizeToFitWidth = true
    $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
  }
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    self.addSubview(self.containerView)
    self.containerView.addSubview(self.criteriaLabel)
    self.containerView.addSubview(self.totalTimeLabel)
    self.containerView.addSubview(self.remainTimeLabel)
    
    self.containerView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-32)
    }
    self.criteriaLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(16)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.lessThanOrEqualToSuperview().offset(-20)
    }
    self.totalTimeLabel.snp.makeConstraints {
      $0.leading.equalTo(self.criteriaLabel).offset(2)
      $0.bottom.equalToSuperview().offset(-14)
    }
    self.remainTimeLabel.snp.makeConstraints {
      $0.top.equalTo(self.criteriaLabel.snp.bottom).offset(8)
      $0.trailing.equalToSuperview().offset(-20)
      $0.leading.greaterThanOrEqualTo(self.totalTimeLabel.snp.trailing).offset(8)
      $0.bottom.equalToSuperview().offset(-16)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.criteriaLabel.text = nil
    self.totalTimeLabel.text = nil
    self.remainTimeLabel.text = nil
  }
  
  func updateUI(_ model: HistorySectionModel) {
    let completedRecords = model.rows
      .filter { $0.workRecord?.startDate != nil && $0.workRecord?.endDate != nil }
    
    let actualWorkRecords = completedRecords
      .filter { $0.workRecord?.isHoliday == false }
    
    let holidayRecords = completedRecords
      .filter { $0.workRecord?.isHoliday == true }
    
    let currentRecords = model.rows
      .filter { $0.workRecord?.startDate != nil && $0.workRecord?.endDate == nil }

    self.criteriaLabel.text = self.criterialLabelString(
      actualWorkRecords,
      holidayRecords: holidayRecords,
      currentRecords: currentRecords
    )
    
    // 이 주의 남은 시간
    // 45시간 기준 9시간 남았어요
    // 45시간 기준 45시간 클리어!
    // 45시간 기준 4시간 초과(총 49시간 근무)
    // 형태로 표출
    
    // TODO: - 로직 함수 쪼개기
    
    // 1. 기준 근무 시간 (ex. 45시간)
    
    let h = RealmService.shared.userInfo.hourOfWorkhoursADay.toRoundedTimeInterval(.hour)
    let m = RealmService.shared.userInfo.minuteOfWorkhoursADay.toRoundedTimeInterval(.minute)
    let totalWorkhoursInterval = (h + m) * Double(RealmService.shared.userInfo.workdaysPerWeekIdxs.count)
    
    self.totalTimeLabel.text = "\(totalWorkhoursInterval.toString(.remain)) 기준"
    
    // 2. 총 일한 시간

    // startDate와 endDate가 존재하는 휴무가 아닌 완료된 근무 기록(일반)들의 timeInterval
    let completedRecordsInterval = actualWorkRecords.compactMap { model -> TimeInterval? in
      if let startDate = model.workRecord?.startDate,
        let endDate = model.workRecord?.endDate {
        return startDate.timeIntervalSince(endDate)
      }
      return nil
    }.reduce(0, +)
    
    // 현재 근무 중인 기록의 timeInterval
    let currentRecordInterval = currentRecords.last.map { model -> Double in
      if let startDate = model.workRecord?.startDate {
        return startDate.timeIntervalSince(Date())
      }
      return 0
    } ?? 0
    
    // 휴무 기록 저장 시 startDate와 endDate를 같게 저장하고 있음
    // 로직을 간소화하려면 이전 휴무 기록들의 endDate를 +9시간 마이그레이션 한 후 로직 변경해야 함
    // -> completedRecordsInterval = actualWorkRecords의 결과가 아니라 completedRecords의 결과로 처리
    let holidayInterval = (h + m) * Double(holidayRecords.count)
    
    // 총 일한 시간
    let actualWorkhoursInterval = -(completedRecordsInterval + currentRecordInterval) + holidayInterval
    
    // 남은 시간: 기준 근무 시간 - 총 일한 시간
    let remainInterval = totalWorkhoursInterval - actualWorkhoursInterval
    
    if remainInterval.isZero {
      self.remainTimeLabel.text = "\(totalWorkhoursInterval.toString(.remain)) 클리어!"
    } else if remainInterval.isLess(than: 0.0) {
      if (-remainInterval).toString(.remain) == "0시간 0분" {
        self.remainTimeLabel.text = "\(totalWorkhoursInterval.toString(.remain)) 클리어!"
      }
      self.remainTimeLabel.text = "\((-remainInterval).toString(.remain)) 초과 (총 \(actualWorkhoursInterval.toString(.remain)) 근무)"
    } else {
      self.remainTimeLabel.text = "\(remainInterval.toString(.remain)) 남았어요"
    }
  }
  
  /// '근무일(1일) 기준', '근무일(4일), 휴무(1일), 초과근무(0일) 기준' 등의 형태로 표출
  fileprivate func criterialLabelString(
    _ actualWorkRecords: [HistoryCellModel],
    holidayRecords: [HistoryCellModel],
    currentRecords: [HistoryCellModel]
  ) -> String {
    // 총 기록 수
    let totalRecordCount = actualWorkRecords.count + currentRecords.count
    // 근무 일 수
    let creteriaWorkDaysCount = RealmService.shared.userInfo.workdaysPerWeekIdxs.count - holidayRecords.count
    // 초과 근무 일 수 (순수 기록 수 - 근무 기준 일 수)
    let overWorkCount = totalRecordCount - creteriaWorkDaysCount
    
    var workdaysString = ""
    if overWorkCount > 0 {
      workdaysString = totalRecordCount > 0 ? "근무일(\(totalRecordCount-overWorkCount)일) ": ""
    } else {
      workdaysString = totalRecordCount > 0 ? "근무일(\(totalRecordCount)일) ": ""
    }
    let holidaysString = holidayRecords.count > 0 ? "휴무(\(holidayRecords.count)일) ": ""
    let overworkString = overWorkCount > 0 ? "초과근무(\(overWorkCount)일)": ""

    return "⏱ \(workdaysString)\(holidaysString)\(overworkString)"
  }
}
