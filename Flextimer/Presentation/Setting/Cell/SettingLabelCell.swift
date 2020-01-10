//
//  SettingLabelCell.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

/// Use 'textLabel' for title, 'subLabel' for description
final class SettingLabelCell: BaseTableViewCell {

  let subLabel = UILabel().then {
    $0.textColor = Color.grayText
    $0.font = Font.REGULAR_16
  }
  
  override func initial() {
    super.initial()
    self.textLabel?.font = Font.REGULAR_16
    self.textLabel?.textColor = Color.primaryText
    self.addSubview(self.subLabel)
    self.subLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-16)
      $0.centerY.equalToSuperview()
    }
  }
  
  func updateUI(_ model: SettingCellModel) {
    self.textLabel?.text = model.title ?? ""
    self.subLabel.text = model.text ?? ""
  }
}
