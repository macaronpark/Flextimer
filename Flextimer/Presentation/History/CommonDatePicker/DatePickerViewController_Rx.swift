//
//  DatePickerViewController_Rx.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/24.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

extension DatePickerViewController {
  
  static func rx(
    parent: UIViewController?,
    current date: Date,
    min: Date? = nil,
    max: Date? = nil,
    mode: UIDatePicker.Mode,
    doneButtonTitle: String
  ) -> Observable<DatePickerViewController> {
    return .create { observer -> Disposable in
      let vc = DatePickerViewController(
        current: date,
        min: min,
        max: max,
        mode: mode,
        doneButtonTitle: doneButtonTitle
      )
      vc.modalPresentationStyle = .overFullScreen
      vc.modalTransitionStyle = .crossDissolve
      
      let disposable = vc.closeSignal.subscribe(onNext: observer.onCompleted)
      
      DispatchQueue.main.async {
        parent?.present(vc, animated: true, completion: nil)
      }
      
      observer.onNext(vc)
      
      return Disposables.create(disposable, Disposables.create {
        vc.dismiss(animated: true, completion: nil)
      })
    }
  }
  
  static func date(
    parent: UIViewController?,
    current date: Date,
    min: Date? = nil,
    max: Date? = nil,
    mode: UIDatePicker.Mode,
    doneButtonTitle: String
  ) -> Observable<Date> {
    return self.rx(
      parent: parent,
      current: date,
      min: min,
      max: max,
      mode: mode,
      doneButtonTitle: doneButtonTitle
    ).flatMap { $0.date }
  }
}
