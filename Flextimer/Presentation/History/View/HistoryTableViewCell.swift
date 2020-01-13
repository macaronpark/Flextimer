//
//  HistoryTableViewCell.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryTableViewCell: BaseTableViewCell {
  
  let titleLabel = UILabel().then {
    $0.textColor = Color.primaryText
    $0.text = "1월 20일"
  }

  let totalWorkhoursADay = UILabel().then {
    $0.textColor = Color.primaryText
    $0.textAlignment = .right
    $0.text = "3시간"
  }

  override func initial() {
    super.initial()
    
    self.addSubview(self.titleLabel)
    self.addSubview(self.totalWorkhoursADay)
    
    self.titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.centerY.equalToSuperview()
    }
    self.totalWorkhoursADay.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-20)
      $0.centerY.equalToSuperview()
    }
    
    self.selectionStyle = .none
    self.accessoryType = .disclosureIndicator
  }
  
  func updateCell() {
    self.titleLabel.text = "1월 20일"
    self.totalWorkhoursADay.text = "3시간 20분"
  }
}
