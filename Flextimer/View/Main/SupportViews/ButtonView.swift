//
//  ButtonView.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/10/07.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import RealmSwift

// todo: refactoring 🤢🤮
struct ButtonView: View {
  
  @EnvironmentObject var userData: UserData
  /// 출근 버튼을 누를 시 분기에 따라 얼럴트를 보여줄지 결정하는 state
  @State private var showingStartAlert = false
  /// 퇴근 버튼을 누를 시 얼럴트를 보여주는 state
  @State private var showingCallOutAlert = false
  // 버튼 넓이: 스크린 넓이 - 양 옆 마진(20*2) - 버튼 사이 마진(16) / 2
  private var buttonWidth = (ScreenSize.width - 40 - 16) / 2
  
  var body: some View {
    HStack(spacing: 16) {
      Group {
        // 출근 버튼
        Button(action: {
          // 오늘 자 기록을 기준으로 분기
          // - 기록이 있다면: 경고 얼럴트
          if let _ = RealmService.shared.getLatestTodayWorkRecord() {
            self.showingStartAlert = true
          } else {
            // - 기록이 없다면: 새로운 WorkRecord를 생성
            let now = Date().trimSeconds() ?? Date()
            let newWorkRecord = WorkRecord(now)
            RealmService.shared.create(newWorkRecord)
            
            self.userData.startDate = now
            self.userData.isWorking = true
          }
        }) {
          Text("출근").frame(width: buttonWidth, height: 42)
            .foregroundColor(.white)
        }
        .alert(isPresented: $showingStartAlert) {
          Alert(
            title: Text("오늘 이미 출근한 기록이 있네요🧐"),
            message: Text("기록을 삭제하고 다시 출근할까요?"),
            primaryButton: .cancel(Text("취소")),
            secondaryButton: .default(Text("출근"),
                                      action: {
                                        if let lastRecord = RealmService.shared.getLatestTodayWorkRecord() {
                                          RealmService.shared.delete(lastRecord)
                                          self.userData.isWorking = false
                                        }
                                        
                                        let now = Date().trimSeconds() ?? Date()
                                        let newWorkRecord = WorkRecord(now)
                                        RealmService.shared.create(newWorkRecord)
                                        
                                        self.userData.startDate = now
                                        self.userData.isWorking = true
            }))
        }
        .disabled(userData.isWorking)
        .background(userData.isWorking ? AppColor.orange.opacity(0.1) : AppColor.orange)
        
        // 퇴근 버튼
        Button(action: {
          self.showingCallOutAlert = true
        }) {
          Text("퇴근").frame(width: buttonWidth, height: 42)
            .foregroundColor(.white)
        }
        .alert(isPresented: $showingCallOutAlert) {
          Alert(
            title: Text("지금 퇴근할까요?🚪"),
            primaryButton: .cancel(Text("취소")),
            secondaryButton: .default(Text("퇴근")) {
              let result = RealmService.shared.realm.objects(WorkRecord.self)
                .filter { $0.endDate == nil }
              if let record = result.last {
                let endDate = ["endDate": Date().trimSeconds() ?? Date()]
                RealmService.shared.update(record, with: endDate)
                self.userData.isWorking = false
                self.userData.ingTimeInterval = nil
              }
            }
          )
        }
        .disabled(!userData.isWorking)
        .background(!userData.isWorking ? AppColor.orange.opacity(0.1) : AppColor.orange)
      }
      .cornerRadius(4)
    }
    .padding(.horizontal, 20)
  }
}

#if DEBUG
struct ButtonView_Previews: PreviewProvider {
  static var previews: some View {
    ButtonView()
      .environmentObject(UserData())
  }
}
#endif
