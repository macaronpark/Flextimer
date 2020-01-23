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
  
  let confirmButton = HistoryButton().then {
    $0.setTitle("출근 시간 변경", for: .normal)
    $0.backgroundColor = Color.pickerGray
  }
  
  var realmID: String?
  
  convenience init(_ date: Date, realmID: String) {
    self.init()
    
    self.pickerView.picker.setDate(date, animated: true)
    self.realmID = realmID
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
  }
  
  override func bind() {
    super.bind()
    
    self.confirmButton.rx.tap
      .bind(onNext: { self.updateStartDate() })
      .disposed(by: self.disposeBag)
  }
  
  func updateStartDate() {
    let workRecord = RealmService.shared.realm
      .objects(WorkRecord.self)
      .filter { $0.id == self.realmID }
      .last
    
    if let workRecord = workRecord {
      RealmService.shared.update(workRecord, with: ["startDate": self.pickerView.picker.date])
      NotificationCenter.default.post(name: RNotiKey.didUpdateWorkhour, object: nil)
    }
    
    DispatchQueue.main.async {
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.dismiss(animated: true, completion: nil)
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.addSubview(self.pickerView)
    self.view.addSubview(self.confirmButton)
    self.pickerView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-16)
    }
    self.confirmButton.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-20)
      $0.size.equalTo(CGSize(width: 120, height: 36))
      $0.bottom.equalTo(self.pickerView.snp.top).offset(-16)
    }
  }
}
