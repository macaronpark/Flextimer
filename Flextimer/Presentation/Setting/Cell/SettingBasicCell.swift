//
//  SettingBasicCell.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

/// Use 'textLabel' for cell title
final class SettingBasicCell: BaseTableViewCell {
  
  override func initial() {
    super.initial()
    self.textLabel?.font = Font.REGULAR_16
    self.textLabel?.textColor = Color.primaryText
  }
  
  func updateUI(_ model: SettingCellModel) {
    self.textLabel?.text = model.title ?? ""
    self.detailTextLabel?.text = model.text ?? ""
  }
}
