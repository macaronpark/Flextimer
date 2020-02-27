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
  
  let titleLabel = UILabel().then {
    $0.textColor = Color.primaryText
    $0.font = Font.REGULAR_16
  }
  
  let stackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 10;
  }

  let subLabel = UILabel().then {
    $0.textColor = Color.secondaryText
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
    self.disclosureIndicatorImageView.snp.makeConstraints {
      $0.width.equalTo(12)
    }

    self.stackView.addArrangedSubview(self.subLabel)
    self.stackView.addArrangedSubview(self.disclosureIndicatorImageView)
    
    self.stackView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-14)
      $0.leading.greaterThanOrEqualToSuperview().offset(8)
    }
  }
  
  func updateUI(_ model: SettingCellModel) {
    if model.component == .none {
      self.disclosureIndicatorImageView.isHidden = true
    } else {
      self.disclosureIndicatorImageView.image = UIImage(systemName: "chevron.right")
    }
    self.titleLabel.text = model.title ?? ""
    self.subLabel.text = model.text ?? ""
  }
  
  func updateWorkhoursUI(_ model: UserInfo) {
    let hourOnly = "\(model.hourOfWorkhoursADay)시간"
    let hourAndMinute = "\(model.hourOfWorkhoursADay)시간 \(RealmService.shared.userInfo.minuteOfWorkhoursADay)분"
    let workhourADayString = (model.minuteOfWorkhoursADay == 0) ? hourOnly: hourAndMinute
    self.subLabel.text = workhourADayString
  }
}
