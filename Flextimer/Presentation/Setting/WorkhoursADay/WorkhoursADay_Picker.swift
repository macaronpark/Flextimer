//
//  WorkhoursADay_Picker.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/12.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

extension WorkhoursADayViewController: UIPickerViewDelegate {
  
  func pickerView(
    _ pickerView: UIPickerView,
    titleForRow row: Int,
    forComponent component: Int
  ) -> String? {
    let hrsStr = "%dhrs".localized(with: [self.hours[row]])
    let minStr = "%dmin".localized(with: [self.minutes[row]])
    
    return (component == 0) ? hrsStr: minStr
  }
}

extension WorkhoursADayViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 2
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return (component == 0) ? self.hours.count: self.minutes.count
  }
}
