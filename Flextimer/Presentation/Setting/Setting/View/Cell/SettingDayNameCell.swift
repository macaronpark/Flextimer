//
//  SettingDayNameCell.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

final class SettingDayNameCell: BaseTableViewCell {
  
  enum Text {
    static let DAY_NAME_0 = "DAY_NAME_0".localized
    static let DAY_NAME_1 = "DAY_NAME_1".localized
    static let DAY_NAME_2 = "DAY_NAME_2".localized
    static let DAY_NAME_3 = "DAY_NAME_3".localized
    static let DAY_NAME_4 = "DAY_NAME_4".localized
    static let DAY_NAME_5 = "DAY_NAME_5".localized
    static let DAY_NAME_6 = "DAY_NAME_6".localized
  }
  
  let buttons:[DayNameButton] = [
    DayNameButton(Text.DAY_NAME_0, idx: 0),
    DayNameButton(Text.DAY_NAME_1, idx: 1),
    DayNameButton(Text.DAY_NAME_2, idx: 2),
    DayNameButton(Text.DAY_NAME_3, idx: 3),
    DayNameButton(Text.DAY_NAME_4, idx: 4),
    DayNameButton(Text.DAY_NAME_5, idx: 5),
    DayNameButton(Text.DAY_NAME_6, idx: 6)
  ]

  let stackView = UIStackView().then {
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
  }
  
  override func initial() {
    super.initial()
    
    self.stackView.addArrangedSubview(buttons[0])
    self.stackView.addArrangedSubview(buttons[1])
    self.stackView.addArrangedSubview(buttons[2])
    self.stackView.addArrangedSubview(buttons[3])
    self.stackView.addArrangedSubview(buttons[4])
    self.stackView.addArrangedSubview(buttons[5])
    self.stackView.addArrangedSubview(buttons[6])

    self.addSubview(self.stackView)
    self.stackView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 20, bottom: 4, right: 20))
    }
  }
}
