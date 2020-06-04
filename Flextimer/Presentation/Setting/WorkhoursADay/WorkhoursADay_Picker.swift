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
        if component == 0 {
            return "%dhrs".localized(with: [self.hours[row]])
        } else {
            return "%dmin".localized(with: [self.minutes[row]])
        }
    }
}

extension WorkhoursADayViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (component == 0) ? self.hours.count : self.minutes.count
    }
}
