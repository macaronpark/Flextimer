//
//  SettingLabelCell.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit
import SnapKit

final class SettingCell: BaseTableViewCell {
  
  var trailingConstraint: Constraint?
  
  let titleLabel = UILabel().then {
    $0.textColor = Color.grayText
    $0.font = Font.REGULAR_16
  }

  let subLabel = UILabel().then {
    $0.textColor = Color.grayText
    $0.font = Font.REGULAR_16
  }
  
  let disclosureIndicatorImageView = UIImageView().then {
    $0.image = UIImage(systemName: "chevron.right")
    $0.tintColor = Color.separatorGray
    $0.contentMode = .scaleAspectFit
  }
  
  override func initial() {
    super.initial()
    
    self.titleLabel.font = Font.REGULAR_16
    self.titleLabel.textColor = Color.primaryText
    self.subLabel.font = Font.REGULAR_16
    self.subLabel.textColor = Color.secondText
    
    self.addSubview(self.titleLabel)
    self.addSubview(self.disclosureIndicatorImageView)
    self.addSubview(self.subLabel)
    
    self.titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.centerY.equalToSuperview()
    }
    
    self.disclosureIndicatorImageView.snp.makeConstraints {
      $0.size.equalTo(20)
      $0.trailing.equalToSuperview().offset(-8)
      $0.centerY.equalToSuperview()
    }

    self.subLabel.snp.makeConstraints {
      $0.leading.greaterThanOrEqualTo(self.titleLabel).offset(8)
      self.trailingConstraint = $0.trailing.equalTo(self.disclosureIndicatorImageView.snp.leading).constraint
      $0.centerY.equalToSuperview()
    }
  }
  
  func updateUI(_ model: SettingCellModel) {
    if model.component == .none {
      self.disclosureIndicatorImageView.image = nil
      self.trailingConstraint?.update(offset: 0)
    } else {
      self.disclosureIndicatorImageView.image = UIImage(systemName: "chevron.right")
      self.trailingConstraint?.update(offset: -8)
    }
    
    self.titleLabel.text = model.title ?? ""
    self.subLabel.text = model.text ?? ""
  }
}
