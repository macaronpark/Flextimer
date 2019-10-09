//
//  ButtonView.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/10/07.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI
import RealmSwift

struct ButtonView: View {
  
  @EnvironmentObject var userData: UserData
  private var buttonWidth = (UIScreen.main.bounds.width - 40 - 16) / 2
  
  var body: some View {
    HStack(spacing: 16) {
      Group {
        // 출근 버튼
        Button(action: { // 새로운 WorkRecord를 생성
          let now = Date()
          let newWorkRecord = WorkRecord(now)
          RealmService.shared.create(newWorkRecord)
          
          self.userData.startDate = now
          self.userData.isWorking = true
        }) {
          Text("출근").frame(width: buttonWidth, height: 42)
          .foregroundColor(.white)
        }
        .disabled(userData.isWorking)
        .background(userData.isWorking ? AppColor.orange.opacity(0.1) : AppColor.orange)
        
        // 퇴근 버튼
        Button(action: {
          let result =  RealmService.shared.realm.objects(WorkRecord.self)
            .sorted(byKeyPath: "date", ascending: true)
          // 임시 삭제
          if let d = result.last {
            RealmService.shared.delete(d)
            self.userData.isWorking = false
          }
        }) {
          Text("퇴근").frame(width: buttonWidth, height: 42)
          .foregroundColor(.white)
        }
        .disabled(!userData.isWorking)
        .background(!userData.isWorking ? AppColor.orange.opacity(0.1) : AppColor.orange)
      }
      .cornerRadius(4)
    }
    .padding(.horizontal, 20)
  }
}

struct ButtonView_Previews: PreviewProvider {
  static var previews: some View {
    ButtonView()
      .environmentObject(UserData())
  }
}
