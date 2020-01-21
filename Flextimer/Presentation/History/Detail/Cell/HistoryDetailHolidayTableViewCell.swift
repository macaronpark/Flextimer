//
//  HistoryDetailHolidayCell.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/21.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryDetailHolidayTableViewCell: BaseTableViewCell {
  
  let titleLabel = UILabel().then {
    $0.textAlignment = .right
    $0.font = Font.REGULAR_16
  }
  
  let switchControl = UISwitch().then {
    $0.onTintColor = Color.immutableOrange
    $0.isOn = false
  }
  
  override func initial() {
    super.initial()
    
    self.selectionStyle = .none
    
    self.addSubview(self.titleLabel)
    self.addSubview(self.switchControl)
    
    self.titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.centerY.equalToSuperview()
    }
    self.switchControl.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-20)
      $0.centerY.equalToSuperview()
    }
  }
  
  func updateCell(_ model: HistoryDetailCellModel) {
    self.titleLabel.text = model.title
    self.titleLabel.textColor = model.textColor
    self.switchControl.isOn = model.isHoliday ?? false
  }
  
}
