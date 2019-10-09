//
//  RootView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/09.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI

struct RootView: View {
  
  init() {
    UINavigationBar.appearance().tintColor = .orange
  }
  
  var body: some View {
    NavigationView {
      MainView()
        .navigationBarItems(trailing: link(destination: SettingView()))
    }
    .onAppear {
      let r = RealmService.shared.realm.objects(WorkRecord.self)
      DebugPrint.debug("\(r)")
    }
  }
  
  private func link<Destination: View>(destination: Destination) -> some View {
      NavigationLink(destination: destination) {
          Image("setting")
          .renderingMode(.init(Image.TemplateRenderingMode.original))
          .resizable()
          .frame(width: 24, height: 24)
      }
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
