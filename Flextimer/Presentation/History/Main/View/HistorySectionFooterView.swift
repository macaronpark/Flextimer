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
    $0.backgroundColor = UIColor.systemFill
  }
  
  let titleLabel = UILabel().then {
    $0.text = "⏱ 이 주의 근무 시간"
    $0.font = Font.SEMIBOLD_16
    $0.textColor = Color.secondaryText
  }
  
  let criteriaLabel = UILabel().then {
    $0.font = Font.REGURAL_12
    $0.textColor = Color.secondaryText
  }
  
  let remainTimeLabel = UILabel().then {
    $0.font = Font.SEMIBOLD_16
    $0.textColor = Color.immutableOrange
  }
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    self.addSubview(self.containerView)
    self.containerView.addSubview(self.titleLabel)
    self.containerView.addSubview(self.criteriaLabel)
    self.containerView.addSubview(self.remainTimeLabel)
    
    self.containerView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-32)
    }
    self.titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(16)
      $0.leading.equalToSuperview().offset(20)
    }
    self.criteriaLabel.snp.makeConstraints {
      $0.centerY.equalTo(self.titleLabel)
      $0.trailing.equalToSuperview().offset(-20)
      $0.leading.greaterThanOrEqualTo(self.titleLabel.snp.trailing).offset(8)
    }
    self.remainTimeLabel.snp.makeConstraints {
      $0.top.equalTo(self.criteriaLabel.snp.bottom).offset(8)
      $0.trailing.equalToSuperview().offset(-20)
      $0.leading.greaterThanOrEqualToSuperview().offset(20)
      $0.bottom.equalToSuperview().offset(-16)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.criteriaLabel.text = nil
    self.remainTimeLabel.text = nil
  }
  
  func updateUI(_ model: HistorySectionModel) {
    let workdaysCount = RealmService.shared.userInfo.workdaysPerWeekIdxs.count
    let holidayCount = model.rows.filter({ $0.workRecord?.isHoliday == true }).count
    
    if holidayCount == 0 {
      self.criteriaLabel.text = "근무일(\(workdaysCount)일) 기준"
    } else {
      self.criteriaLabel.text = "근무일(\(workdaysCount-holidayCount)일), 휴무(\(holidayCount)일) 기준"
    }
    
    // 이 주의 남은 시간
    // 1. 총 근무 시간
    let h = RealmService.shared.userInfo.hourOfWorkhoursADay.toRoundedTimeInterval(.hour)
    let m = RealmService.shared.userInfo.minuteOfWorkhoursADay.toRoundedTimeInterval(.minute)
    let totalWorkhoursInterval = (h + m) * Double(workdaysCount)
    // 2. 총 일한 시간
    let actualWorkhoursInterval = model.rows.compactMap { model -> TimeInterval? in
      if let startDate = model.workRecord?.startDate,
        let endDate = model.workRecord?.endDate {
        return startDate.timeIntervalSince(endDate)
      }
      return nil
    }.reduce(0, +)
    
    let holidayInterval = (h + m) * Double(holidayCount)
  
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
}
