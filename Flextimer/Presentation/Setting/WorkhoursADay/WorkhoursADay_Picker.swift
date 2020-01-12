//
//  Workdayhours_Picker.swift
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
    return (component == 0) ? "\(self.hours[row])시간": "\(self.minutes[row])분"
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.updateRealm(row, inComponent: component)
  }
  
  func updateRealm(_ row: Int, inComponent component: Int) {
    let value: Int = (component == 0) ? self.hours[row]: self.minutes[row]
    let type: UserInfoEnum = (component == 0) ? .hourOfWorkhoursADay: .minuteOfWorkhoursADay
    
    RealmService.shared.update(
      RealmService.shared.userInfo,
      with: [type.self.str: value]
    )
    
    let criteria = (type == .hourOfWorkhoursADay)
    let name: RNotiKey = criteria ? .didUpdateHourOfWorkhoursADay: .didUpdateMinuteOfWorkhoursADay
    DispatchQueue.main.async {
      NotificationCenter.default.post(name: name, object: nil)
    }
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
