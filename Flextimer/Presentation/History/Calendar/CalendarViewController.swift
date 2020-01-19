//
//  CalendarViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/19.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit
import SnapKit

class CalendarViewController: BaseViewController {
  
  lazy var pickerView = CalendarPickerView().then {
    $0.picker.delegate = self
  }
  
  override init() {
    super.init()
  }
  
  convenience init(_ model: UserInfo) {
    self.init()
    
//    self.pickerView.selectRow(model.hourOfWorkhoursADay - 1, inComponent: 0, animated: true)
//    self.pickerView.selectRow(minutes.lastIndex(of: model.minuteOfWorkhoursADay) ?? 0, inComponent: 1, animated: true)
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
