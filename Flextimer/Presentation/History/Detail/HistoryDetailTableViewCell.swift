//
//  HistoryDetailTableViewCell.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/21.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryDetailTableViewCell: BaseTableViewCell {
  
  let stackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 10;
  }

  let subTitleLabel = UILabel().then {
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
    
    self.selectionStyle = .none
    
    self.addSubview(self.subTitleLabel)
    self.addSubview(self.disclosureIndicatorImageView)
    
    self.disclosureIndicatorImageView.snp.makeConstraints {
      $0.size.equalTo(CGSize(width: 16, height: 16))
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-20)
    }
    self.subTitleLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalTo(self.disclosureIndicatorImageView.snp.leading).offset(-8)
    }
  }
  
  func updateCell(_ workRecord: WorkRecord, indexPath: IndexPath) {
    
    switch (indexPath.section, indexPath.row) {
    case (0, 0):
      self.subTitleLabel.text = Formatter.dayName.string(from: workRecord.startDate)
      self.subTitleLabel.textColor = Color.grayText
      
    case (0, 1):
      self.subTitleLabel.text = Formatter.shm.string(from: workRecord.startDate)
      self.subTitleLabel.textColor = Color.primaryText
      
    case (1, 0):
      self.subTitleLabel.text = Formatter.dayName.string(from: workRecord.endDate ?? Date())
      self.subTitleLabel.textColor = Color.grayText
      
    case (1, 1):
      self.subTitleLabel.text = Formatter.shm.string(from: workRecord.endDate ?? Date())
      self.subTitleLabel.textColor = Color.primaryText
      
    default:
      break
    }
  }
}
