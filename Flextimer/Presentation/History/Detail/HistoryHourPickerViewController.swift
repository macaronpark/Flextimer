//
//  HistoryHourPickerViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/21.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit
import SnapKit

class HistoryHourPickerViewController: BaseViewController {

  let pickerView = HistoryHourPickerView().then {
    $0.picker.datePickerMode = .time
  }
  
  convenience init(_ date: Date) {
    self.init()
    
    self.pickerView.picker.setDate(date, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.dismiss(animated: true, completion: nil)
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.addSubview(self.pickerView)
    self.pickerView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-16)
    }
  }
}
