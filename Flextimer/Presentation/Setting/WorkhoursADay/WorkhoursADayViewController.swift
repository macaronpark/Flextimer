//
//  WorkhoursADayViewController.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/12.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class WorkhoursADayViewController: BaseViewController {
  
  enum Text {
    static let TVC_EDIT_RECORD = "TVC_EDIT_RECORD".localized
  }
  
  let hours: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
  
  let minutes: [Int] = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
  
  var impactGenerator: UIImpactFeedbackGenerator?
  
  lazy var pickerView = PickerView().then {
    $0.picker.delegate = self
    $0.picker.dataSource = self
  }
  
  let confirmButton = HistoryButton().then {
    $0.backgroundColor = Color.pickerGray
    $0.setTitleColor(Color.immutableOrange, for: .normal)
    $0.setTitle(Text.TVC_EDIT_RECORD, for: .normal)
  }
  
  
  // MARK: - Init
  
  override init() {
    super.init()
  }
  
  convenience init(_ model: UserInfo) {
    self.init()
    
    self.impactGenerator = UIImpactFeedbackGenerator(style: .medium)
    self.pickerView.picker.selectRow(model.hourOfWorkhoursADay - 1, inComponent: 0, animated: true)
    self.pickerView.picker.selectRow(minutes.lastIndex(of: model.minuteOfWorkhoursADay) ?? 0, inComponent: 1, animated: true)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Lifecycles
  
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
    
    let share = self.confirmButton.rx.tap
    let pickerItemSelected = self.pickerView.picker.rx.itemSelected.asObservable()
    
    share
      .withLatestFrom(pickerItemSelected)
      .subscribe(onNext: { [weak self] row, component in
        self?.updateRealm(row, inComponent: component)
      }).disposed(by: self.disposeBag)

    share
      .bind(onNext: { [weak self] in
        self?.dismiss(animated: true, completion: nil)
      }).disposed(by: self.disposeBag)
      
    share
      .bind(onNext: { [weak self] in
        self?.impactGenerator?.impactOccurred()
      }).disposed(by: self.disposeBag)
  }
  
  func updateRealm(_ row: Int, inComponent component: Int) {
    let value: Int = (component == 0) ? self.hours[row]: self.minutes[row]
    let type: UserInfoEnum = (component == 0) ? .hourOfWorkhoursADay: .minuteOfWorkhoursADay
    
    RealmService.shared.update(
      RealmService.shared.userInfo,
      with: [type.self.str: value]
    )
  }
}
