//
//  UserData.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/08.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

//import SwiftUI
import Combine
import Foundation

//final class UserData: ObservableObject {
//
//  private var cancellables = Set<AnyCancellable>()
//
//  /// 일주일 중 일하는 요일
//  @Published var workdays: [Int] = RealmService.shared.userInfo.workdays.compactMap { Int($0) }
//  /// 하루에 일하는 시간
//  @Published var workingHours = CurrentValueSubject<Int, Never>(RealmService.shared.userInfo.workingHours - 1)
//  /// 현재 근무 중 인지
//  @Published var isWorking: Bool = RealmService.shared.isWorking()
//
//  /// 출근기록이 있다면: 근무 시작 date
//  @Published var startDate: Date?
//  /// 출근기록이 있다면: 퇴근까지 남은 시간
//  @Published var remainTime: String = ""
//  /// 출근기록이 있다면: 출근부터 현재까지의 타임 인터벌
//  @Published var ingTimeInterval: TimeInterval? = nil
//
//  /// 오늘 근무 시작 시간을 '오전 0시 0분'으로 변환한 string
//  var startTime: String {
//    return Formatter.shm.string(from: self.startDate ?? Date())
//  }
//
//  /// 예상 퇴근 시간
//  var estimatedEndTime: String {
//    let callOutDate = Calendar.current.date(
//      byAdding: .hour,
//      value: +self.workingHours.value + 1,
//      to: self.startDate ?? Date()
//      ) ?? Date()
//    return Formatter.shm.string(from: callOutDate)
//  }
//
//  init() {
//    // 현재 근무 중이라면 퇴근 기록이 없는 마지막 레코드를 가져온다
//    if self.isWorking {
//      if let record = RealmService.shared.getLastWorkingRecord() {
//        self.startDate = record.date
//      }
//    }
//
//    // todo: Refactoring
//    self.binding()
//  }
//
//  fileprivate func binding() {
//    self.workingHours.sink { hour in
//      let workHour = hour + 1
//
//      RealmService.shared.update(
//        RealmService.shared.userInfo,
//        with: ["workingHours": workHour]
//      )
//    }.store(in: &cancellables)
//  }
//}
