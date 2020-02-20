//
//  HistoryTableViewCell.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryTableViewCell: BaseTableViewCell {
  
  enum Text {
    static let HTVC_OFF = "HTVC_OFF".localized
    static let HTVC_AT_WORK_RIGHT_NOW = "HTVC_AT_WORK_RIGHT_NOW".localized
  }
  
  let titleLabel = UILabel().then {
    $0.textColor = Color.primaryText
    $0.font = Font.REGULAR_16
  }
  
  let stackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 10;
  }

  let totalWorkhoursADayLabel = UILabel().then {
    $0.textColor = Color.primaryText
    $0.textAlignment = .right
    $0.font = Font.REGULAR_16
  }
  
  let disclosureIndicatorImageView = UIImageView().then {
    $0.image = UIImage(systemName: "chevron.right")
    $0.tintColor = Color.separatorGray
    $0.contentMode = .scaleAspectFit
  }
  
  override func initial() {
    super.initial()
    
    self.addSubview(self.titleLabel)
    self.addSubview(self.stackView)
    
    self.titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.centerY.equalToSuperview()
    }
    self.stackView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-14)
      $0.leading.greaterThanOrEqualTo(self.titleLabel.snp.trailing).offset(8)
    }
    self.disclosureIndicatorImageView.snp.makeConstraints {
      $0.size.equalTo(CGSize(width: 16, height: 16))
    }
    
    self.stackView.addArrangedSubview(self.totalWorkhoursADayLabel)
    self.stackView.addArrangedSubview(self.disclosureIndicatorImageView)
  }
  
  func updateCell(_ model: HistoryCellModel, isWorkday: Bool) {
    self.titleLabel.text = Formatter.dayName.string(from: model.date)
    
    if let endDate = model.workRecord?.endDate {
      let timeInterval = -(model.workRecord?.startDate.timeIntervalSince(endDate) ?? 0)
      self.totalWorkhoursADayLabel.text = timeInterval.toString(.week)
    } else {
      self.totalWorkhoursADayLabel.text = ""
      // 유저 시스템에 등록된 근무 일인지 판단, 아니라면 디폴트로 '-'를 라벨에 표출
      if !isWorkday {
        self.totalWorkhoursADayLabel.text = "-"
      }
    }

    self.disclosureIndicatorImageView.isHidden = !(model.workRecord != nil)
    
    let textColor: UIColor = (Calendar.current.isDateInToday(model.date)) ? Color.primaryText: Color.secondaryText
    self.titleLabel.textColor = textColor
    self.totalWorkhoursADayLabel.textColor = textColor
    
    if let isHoliday = model.workRecord?.isHoliday {
      if isHoliday == true {
        self.disclosureIndicatorImageView.isHidden = isHoliday
        self.totalWorkhoursADayLabel.text = Text.HTVC_OFF;
      }
    }
    
    // 오늘 근무 중인 기록은 따로 처리
    if Calendar.current.isDate(model.date, inSameDayAs: Date()) {
      
      let workRecordOfToday: WorkRecord? = RealmService.shared.realm
        .objects(WorkRecord.self)
        .filter { record in
          if (Calendar.current.isDateInToday(record.startDate) && record.endDate == nil) {
            return true
          }
          
          if (record.endDate == nil) {
            return true
          }
          
          return false
      }
      .last
      
      if let _ = workRecordOfToday {
        self.totalWorkhoursADayLabel.text = Text.HTVC_AT_WORK_RIGHT_NOW
        self.disclosureIndicatorImageView.isHidden = true
      }
    }
  }
}
