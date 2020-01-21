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
    self.addSubview(self.stackView)

    self.stackView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-14)
    }
    self.disclosureIndicatorImageView.snp.makeConstraints {
      $0.size.equalTo(CGSize(width: 16, height: 16))
    }
    self.stackView.addArrangedSubview(self.subTitleLabel)
    self.stackView.addArrangedSubview(self.disclosureIndicatorImageView)
  }
  
  func updateCell(_ model: HistoryDetailCellModel) {
    self.subTitleLabel.text = model.title
    self.subTitleLabel.textColor = model.textColor
    self.disclosureIndicatorImageView.isHidden = !(model.isEditable ?? false)
  }
}
