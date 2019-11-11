//
//  SettingView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import UIKit
import SwiftUI
import Combine
import RealmSwift

struct SettingView: View {
  @EnvironmentObject var userData: UserData
  let days = ["월", "화", "수", "목", "금", "토", "일"]

  var body: some View {
    Form {
      Section(header: Text("주 근무 요일")) {
        HStack {
          ForEach(0 ..< days.count) { idx in
            Spacer()
            Text(self.days[idx])
              .padding(8)
              .background(self.userData.workdays.contains(idx) ? AppColor.orange: Color.gray)
              .foregroundColor(.white)
              .cornerRadius(6)
              .onTapGesture {

                if self.userData.workdays.contains(idx) {
                  if let index = self.userData.workdays.firstIndex(of: idx) {
                    self.userData.workdays.remove(at: index)
                  }
                } else {
                  self.userData.workdays.append(idx)
                }

                let sorted = self.userData.workdays.sorted { $0 < $1 }
                self.userData.workdays = sorted
                RealmService.shared.update(
                  RealmService.shared.userInfo(),
                  with: ["workdays": sorted]
                )
            }
            Spacer()
          }
        }
      }
        
    Section(header: Text("기타")) {
        
        HStack {
            Text("버전")
            Spacer()
            Text(isUpdateAvailable() ? "🚀 업데이트 하러가기": "\(clientVersion)(최신버전)")
                .foregroundColor(isUpdateAvailable() ? Color.primary: Color.secondary)
        }.onTapGesture {
            if self.isUpdateAvailable() {
                let urlStr = "https://itunes.apple.com/app/id1484457501"
                guard let url = URL(string: urlStr) else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        NavigationLink(destination: OpensourceView()) {
            Text("오픈소스")
        }
        
        HStack {
            Text("개발자")
            Spacer()
            Text("github.com/macaronpark").foregroundColor(.gray)
            
        }.onTapGesture {
                if let url = URL(string: "https://github.com/macaronpark") {
                    UIApplication.shared.open(url)
                }
            }
        }
    }.navigationBarTitle(Text("설정"))
  }
    
    
    var clientVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    func isUpdateAvailable() -> Bool {
        // todo: 앱 스토어 번들 ID 필요
        guard let url = URL(string: "http://itunes.apple.com/lookup?bundleId=모이고하스피톨번들ID"),
            let data = try? Data(contentsOf: url),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
            let results = json["results"] as? [[String: Any]], results.count > 0,
            let appStoreVersion = results[0]["version"] as? String else {
                return false
        }
        return !(clientVersion == appStoreVersion) ? true : false
    }
    
}

#if DEBUG
struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView().environmentObject(UserData())
  }
}
#endif
