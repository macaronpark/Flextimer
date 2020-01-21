//
//  HistoryDetailDeleteTableViewCell.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/21.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryDetailDeleteTableViewCell: BaseTableViewCell {
  
  let titleLabel = UILabel().then {
    $0.textColor = Color.primaryText
    $0.textAlignment = .right
    $0.font = Font.REGULAR_16
    $0.textColor = Color.grayText
    $0.text = "기록 삭제"
  }
  
  override func initial() {
    super.initial()
    
    self.selectionStyle = .none
    
    self.addSubview(self.titleLabel)
    self.titleLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
  
  func updateCell(_ model: HistoryDetailCellModel) {
    self.titleLabel.text = model.title
    self.titleLabel.textColor = model.textColor
  }
}
