//
//  PickerViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/12.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit
import SnapKit

class WorkdayhoursADayViewController: BaseViewController {
  
  let hours: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  let minutes: [Int] = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60]
  
  lazy var pickerView = PickerView().then {
    $0.picker.delegate = self
    $0.picker.dataSource = self
  }
  
  override init() {
    super.init()
  }
  
  convenience init(_ model: UserInfo) {
    self.init()
    
    self.pickerView.picker.selectRow(model.hourOfWorkhoursADay - 1, inComponent: 0, animated: true)
    self.pickerView.picker.selectRow(minutes.lastIndex(of: model.minuteOfWorkhoursADay) ?? 0, inComponent: 1, animated: true)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
