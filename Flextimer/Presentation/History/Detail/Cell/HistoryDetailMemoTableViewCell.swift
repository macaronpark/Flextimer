//
//  HistoryDetailMemoTableViewCell.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/02/06.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryDetailMemoTableViewCell: BaseTableViewCell {
  
  let memoTextView = UITextView().then {
    $0.textColor = Color.primaryText
    $0.font = Font.REGULAR_16
    $0.isScrollEnabled = false
  }

  override func initial() {
    super.initial()
    
    self.selectionStyle = .none
    self.addSubview(self.memoTextView)

    self.memoTextView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(8)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalToSuperview().offset(-8)
    }
  }
  
  func updateCell(_ model: HistoryDetailCellModel) {
//    self.subTitleLabel.text = model.title
//    self.subTitleLabel.textColor = model.textColor
//    self.disclosureIndicatorImageView.isHidden = !(model.isEditable ?? false)
  }
}
