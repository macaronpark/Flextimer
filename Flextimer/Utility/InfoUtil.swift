//
//  InfoUtil.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import Foundation

class InfoUtil {

  static var versionDescription: (isAvailable: Bool, text: String) {
    let clientVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    guard let url = URL(string: "https://itunes.apple.com/app/id1484457501"),
      let data = try? Data(contentsOf: url),
      let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
      let results = json["results"] as? [[String: Any]], results.count > 0,
      let appStoreVersion = results[0]["version"] as? String else {
        return (false, "")
    }
    return !(clientVersion == appStoreVersion) ? (true, "🚀 업데이트 하러가기") : (false, "최신 버전(\(clientVersion))")
  }
}
