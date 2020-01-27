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

class DatePickerViewController: BaseViewController {

  var date: BehaviorRelay<Date>!
  
  let closeSignal = PublishRelay<Void>()
  
  var pickerView: DatePickerView!
  
  var impactGenerator: UIImpactFeedbackGenerator?
  
  let confirmButton = HistoryButton().then {
    $0.backgroundColor = Color.pickerGray
    $0.setTitleColor(Color.immutableOrange, for: .normal)
  }
  
  
  // MARK: - Init
  
  override init() {
    super.init()
  }
  
  /// currentDate: 현재 선택한 날짜
  convenience init(
    current date: Date,
    min: Date? = nil,
    max: Date? = nil,
    mode: UIDatePicker.Mode,
    doneButtonTitle: String
  ) {
    self.init()
    
    self.date = .init(value: date)
    self.confirmButton.setTitle(doneButtonTitle, for: .normal)
    self.pickerView = DatePickerView(frame: .zero).then {
      $0.picker.minimumDate = min
      $0.picker.maximumDate = max
      $0.picker.date = date
      $0.picker.datePickerMode = mode
    }
    
    self.impactGenerator = UIImpactFeedbackGenerator(style: .medium)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Lifecycles
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.triggerImpact()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.closeSignal.accept(())
  }
  
  private func triggerImpact() {
    self.impactGenerator?.impactOccurred()
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
      $0.size.equalTo(CGSize(width: 100, height: 40))
      $0.bottom.equalTo(self.pickerView.snp.top).offset(-16)
    }
  }
  
  override func bind() {
    super.bind()
    
    let single = self.confirmButton.rx.tap
    
    single
      .withLatestFrom(self.pickerView.picker.rx.date)
      .bind(to: self.date)
      .disposed(by: self.disposeBag)
    
    single
      .bind(to: self.closeSignal)
      .disposed(by: self.disposeBag)
    
    single
      .bind(onNext: { [weak self] in self?.triggerImpact() })
      .disposed(by: self.disposeBag)
  }
}
