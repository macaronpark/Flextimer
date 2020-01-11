//
//  SettingDayNameCell.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

final class SettingDayNameCell: BaseTableViewCell {
  
  let buttons:[DayNameButton] = [
  DayNameButton("월", idx: 0),
  DayNameButton("화", idx: 1),
  DayNameButton("수", idx: 2),
  DayNameButton("목", idx: 3),
  DayNameButton("금", idx: 4),
  DayNameButton("토", idx: 5),
  DayNameButton("일", idx: 6)
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
