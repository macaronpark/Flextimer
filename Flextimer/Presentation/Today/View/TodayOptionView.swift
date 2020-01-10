//
//  TodayOptionView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import SnapKit
import Then

class TodayOptionView: UIView {
  
  let workhoursPerDayLabel = UILabel().then {
    $0.font = Font.REGURAL_14
    $0.textColor = Color.grayText
    $0.text = "일 9시간 30분"
  }
  
  let firstSeparatorLabel = UILabel().then {
    $0.font = Font.REGURAL_14
    $0.textColor = Color.grayText
    $0.text = " ・ "
  }
  
  let workdaysPerWeekLabel = UILabel().then {
    $0.font = Font.REGURAL_14
    $0.textColor = Color.grayText
    $0.text = "주 5일"
  }
  
  let secondSeparatorLabel = UILabel().then {
    $0.font = Font.REGURAL_14
    $0.textColor = Color.grayText
    $0.text = " ・ "
  }
  
  let totalWorkhoursPerWeekLabel = UILabel().then {
    $0.font = Font.REGURAL_14
    $0.textColor = Color.grayText
    $0.text = "45시간 기준"
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.addSubview(self.workhoursPerDayLabel)
    self.addSubview(self.firstSeparatorLabel)
    self.addSubview(self.workdaysPerWeekLabel)
    self.addSubview(self.secondSeparatorLabel)
    self.addSubview(self.totalWorkhoursPerWeekLabel)
    
    self.workhoursPerDayLabel.snp.makeConstraints {
      $0.top.leading.bottom.equalToSuperview()
    }
    self.firstSeparatorLabel.snp.makeConstraints {
      $0.top.equalTo(self.workhoursPerDayLabel)
      $0.leading.equalTo(self.workhoursPerDayLabel.snp.trailing)
    }
    self.workdaysPerWeekLabel.snp.makeConstraints {
      $0.top.equalTo(self.workhoursPerDayLabel)
      $0.leading.equalTo(self.firstSeparatorLabel.snp.trailing)
    }
    self.secondSeparatorLabel.snp.makeConstraints {
      $0.top.equalTo(self.workhoursPerDayLabel)
      $0.leading.equalTo(self.workdaysPerWeekLabel.snp.trailing)
    }
    self.totalWorkhoursPerWeekLabel.snp.makeConstraints {
      $0.top.equalTo(self.workhoursPerDayLabel)
      $0.leading.equalTo(self.secondSeparatorLabel.snp.trailing)
      $0.trailing.greaterThanOrEqualTo(self)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
