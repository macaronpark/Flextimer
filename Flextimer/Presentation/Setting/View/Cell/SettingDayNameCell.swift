//
//  SettingDayNameCell.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

final class SettingDayNameCell: BaseTableViewCell {
  
  let mon = DayNameButton("월")
  let tue = DayNameButton("화")
  let wed = DayNameButton("수")
  let thu = DayNameButton("목")
  let fri = DayNameButton("금")
  let sat = DayNameButton("토")
  let sun = DayNameButton("일")
  
  let stackView = UIStackView().then {
    $0.axis = .horizontal
    $0.distribution = .equalSpacing
  }
  
  override func initial() {
    super.initial()
    
    self.stackView.addArrangedSubview(mon)
    self.stackView.addArrangedSubview(tue)
    self.stackView.addArrangedSubview(wed)
    self.stackView.addArrangedSubview(thu)
    self.stackView.addArrangedSubview(fri)
    self.stackView.addArrangedSubview(sat)
    self.stackView.addArrangedSubview(sun)
    
    self.addSubview(self.stackView)
    self.stackView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 20, bottom: 4, right: 20))
    }
  }
}
