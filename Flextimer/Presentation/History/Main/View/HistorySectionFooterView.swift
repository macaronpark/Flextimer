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
    $0.font = Font.SEMIBOLD_16
    $0.textColor = Color.secondaryText
  }
  
  let remainTimeLabel = UILabel().then {
    $0.font = Font.SEMIBOLD_16
    $0.textColor = Color.immutableOrange
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
      $0.top.equalTo(self.criteriaLabel.snp.bottom).offset(8)
      $0.bottom.equalToSuperview().offset(-16)
    }
    self.remainTimeLabel.snp.makeConstraints {
      $0.top.equalTo(self.totalTimeLabel)
      $0.trailing.equalToSuperview().offset(-20)
      $0.leading.greaterThanOrEqualTo(self.totalTimeLabel.snp.trailing).offset(8)
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
    // 45시간 기준 4시간 초과
    
    // 1. 총 근무 시간
    let h = RealmService.shared.userInfo.hourOfWorkhoursADay.toRoundedTimeInterval(.hour)
    let m = RealmService.shared.userInfo.minuteOfWorkhoursADay.toRoundedTimeInterval(.minute)
    let totalWorkhoursInterval = (h + m) * Double(RealmService.shared.userInfo.workdaysPerWeekIdxs.count)
    
    self.totalTimeLabel.text = "\(totalWorkhoursInterval.toString(.remain)) 기준"
    
    // 2. 총 일한 시간
    let actualWorkhoursInterval = model.rows.compactMap { model -> TimeInterval? in
      if let startDate = model.workRecord?.startDate,
        let endDate = model.workRecord?.endDate {
        return startDate.timeIntervalSince(endDate)
      }
      return nil
    }.reduce(0, +)
    
    let holidayInterval = (h + m) * Double(holidayRecords.count)
  
    let remainInterval = totalWorkhoursInterval - (-actualWorkhoursInterval) - holidayInterval
    
    if remainInterval.isZero {
      self.remainTimeLabel.text = "\(totalWorkhoursInterval.toString(.remain)) 클리어!"
    } else if remainInterval.isLess(than: 0.0) {
      if (-remainInterval).toString(.remain) == "0시간 0분" {
        self.remainTimeLabel.text = "\(totalWorkhoursInterval.toString(.remain)) 클리어!"
      }
      self.remainTimeLabel.text = "\((-remainInterval).toString(.remain)) 초과"
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
    let totalRecordCount = actualWorkRecords.count + currentRecords.count
    let creteriaWorkDaysCount = RealmService.shared.userInfo.workdaysPerWeekIdxs.count - holidayRecords.count
    let overWorkCount = totalRecordCount - creteriaWorkDaysCount
    
    let workdaysString = actualWorkRecords.count > 0 ? "근무일(\(actualWorkRecords.count)일) ": ""
    let holidaysString = holidayRecords.count > 0 ? "휴무(\(holidayRecords.count)일) ": ""
    let overworkString = overWorkCount > 0 ? "초과근무(\(overWorkCount)일)": ""

    return "⏱ \(workdaysString)\(holidaysString)\(overworkString)"
  }
}
