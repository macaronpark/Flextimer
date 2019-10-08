//
//  UserData.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/08.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

final class UserData: ObservableObject  {
  /// 일주일에 일하는 일 수
  @Published var workdaysCount: Int = 5
  /// 하루에 일하는 시간
  @Published var officeHours: Int = 9
  
  /// 현재 근무 중 인지
  @Published var isWorking: Bool = false
  /// 오늘 근무 시작 date
  @Published var startDate: Date?
  
  /// 오늘 근무 시작 시간을 '오전 0시 0분'으로 변환한 string
  var startTime: String {
    return Formatter.shm.string(from: self.startDate ?? Date())
  }
  
  var callOutTime: String {
    let callOutDate = Calendar.current.date(
      byAdding: .hour,
      value: +self.officeHours,
      to: self.startDate ?? Date()
    )
    return Formatter.shm.string(from: callOutDate ?? Date())
  }
  
  init() {
    self.isWorking = RealmService.shared.isWorking()
    
    if self.isWorking {
      
      // todo: 밤 12시가 지나면 초기화 시키는 이슈 해결하기
      guard let record = RealmService.shared.realm.objects(WorkRecord.self).last else { return }
      self.startDate = record.date
    }
  }
}

