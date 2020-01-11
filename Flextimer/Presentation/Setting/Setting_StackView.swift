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
    let indexPath = IndexPath(row: 0, section: 1)
    if let cell = self.tableView.cellForRow(at: indexPath) as? SettingDayNameCell {
      
      let monButton = cell.buttons[0]
      let tueButton = cell.buttons[1]
      let wedButton = cell.buttons[2]
      let thuButton = cell.buttons[3]
      let friButton = cell.buttons[4]
      let satButton = cell.buttons[5]
      let sunButton = cell.buttons[6]
      
      monButton.rx.tap
        .bind(onNext: { monButton.toggle() })
        .disposed(by: self.disposeBag)
      
      tueButton.rx.tap
      .bind(onNext: { tueButton.toggle() })
      .disposed(by: self.disposeBag)
      
      wedButton.rx.tap
      .bind(onNext: { wedButton.toggle() })
      .disposed(by: self.disposeBag)
      
      thuButton.rx.tap
      .bind(onNext: { thuButton.toggle() })
      .disposed(by: self.disposeBag)
      
      friButton.rx.tap
      .bind(onNext: { friButton.toggle() })
      .disposed(by: self.disposeBag)
      
      satButton.rx.tap
      .bind(onNext: { satButton.toggle() })
      .disposed(by: self.disposeBag)
      
      sunButton.rx.tap
      .bind(onNext: { sunButton.toggle() })
      .disposed(by: self.disposeBag)
    }
  }
}
