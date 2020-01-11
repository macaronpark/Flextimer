//
//  Setting_StackView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

extension SettingViewController {
  
  func bindStackViewButtons() {
    if let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? SettingDayNameCell {
      
      let mondayButton = cell.mon
      let tuesdayButton = cell.tue
      let wednesButton = cell.wed
      let thursdayButton = cell.thu
      let fridayButton = cell.fri
      let saturdayButton = cell.sat
      let sundayButton = cell.sun
      
      mondayButton.rx.tap.bind(onNext: {
        mondayButton.selectedUpdate()
        print(mondayButton.isSelected)
      }).disposed(by: self.disposeBag)
      
      tuesdayButton.rx.tap.bind(onNext: { tuesdayButton.selectedUpdate() }).disposed(by: self.disposeBag)
      wednesButton.rx.tap.bind(onNext: { wednesButton.selectedUpdate() }).disposed(by: self.disposeBag)
      thursdayButton.rx.tap.bind(onNext: { thursdayButton.selectedUpdate() }).disposed(by: self.disposeBag)
      fridayButton.rx.tap.bind(onNext: { fridayButton.selectedUpdate() }).disposed(by: self.disposeBag)
      saturdayButton.rx.tap.bind(onNext: { saturdayButton.selectedUpdate() }).disposed(by: self.disposeBag)
      sundayButton.rx.tap.bind(onNext: { sundayButton.selectedUpdate() }).disposed(by: self.disposeBag)
    }
  }
}
