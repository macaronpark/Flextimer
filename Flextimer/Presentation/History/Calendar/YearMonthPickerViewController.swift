//
//  CalendarViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/19.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol YearMonthPickerDelegate: class {
  func didCalendarPickerSelected(year: Int, month: Int)
}

class YearMonthPickerViewController: BaseViewController {
  
  weak var delegate: YearMonthPickerDelegate?
  
  lazy var pickerView = YearMonthPickerView().then {
    $0.picker.delegate = self
  }
  
  let confirmButton = HistoryButton().then {
    $0.setTitle("기록 조회", for: .normal)
    $0.backgroundColor = Color.pickerGray
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    DispatchQueue.main.async {
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    
    self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    self.view.addSubview(self.pickerView)
    self.view.addSubview(self.confirmButton)
    
    self.pickerView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-16)
    }
    self.confirmButton.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-20)
      $0.size.equalTo(CGSize(width: 100, height: 36))
      $0.bottom.equalTo(self.pickerView.snp.top).offset(-16)
    }
  }
  
  override func bind() {
    super.bind()
    
    self.confirmButton.rx.tap
      .bind { [weak self] _ in
        guard let self = self else { return }
        
        let picker = self.pickerView.picker
        let year = picker.selectedRow(inComponent: 0)
        let month = picker.selectedRow(inComponent: 1)
        
        self.delegate?.didCalendarPickerSelected(
          year: picker.years[year],
          month: picker.months[month]
        )
        
        DispatchQueue.main.async {
          self.dismiss(animated: true, completion: nil)
        }
    }.disposed(by: self.disposeBag)
  }
}
