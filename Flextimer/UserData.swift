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
  @Published var workingHours: Int = 9
  
  /// 현재 근무 중 인지
  @Published var isWorking: Bool = false
  /// 현재 근무 시작 date
  @Published var startDate: Date?
  @Published var remainTime: String = ""
  
  /// 오늘 근무 시작 시간을 '오전 0시 0분'으로 변환한 string
  var startTime: String {
    return Formatter.shm.string(from: self.startDate ?? Date())
  }
  
  /// 예상 퇴근 시간
  var estimatedCallOutTime: String {
    let callOutDate = Calendar.current.date(
      byAdding: .hour,
      value: +self.workingHours,
      to: self.startDate ?? Date()
    ) ?? Date()
    return Formatter.shm.string(from: callOutDate)
  }
  
  init() {
    // 현재 근무 중 인지 판단
    self.isWorking = RealmService.shared.isWorking()
    // 현재 근무 중이라면 퇴근 기록이 없는 마지막 레코드를 가져온다
    if self.isWorking {
      let record = RealmService.shared.realm.objects(WorkRecord.self).filter { $0.endDate == nil }
      if !record.isEmpty, let lastRecord = record.last {
        self.startDate = lastRecord.date
      }
    }
  }
}
