//
//  WidgetButton.swift
//  Widget
//
//  Created by Suzy Park on 2019/10/18.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import UIKit

class WidgetButton: UIButton {
  
  enum Text {
    static let HDVM_START = "HDVM_START".localized
    static let HDVM_END = "HDVM_END".localized
  }

  enum WidgetButtonType {
    case start
    case end

    var title: String {
      switch self {
      case .start:
        return Text.HDVM_START
      case .end:
        return Text.HDVM_END
      }
    }
  }

  /// 버튼 타입 별 title, titleColor, backgroundColor 설정
  func setBasicConfig(_ type: WidgetButtonType) {
    self.setTitle(type.title, for: .normal)
    self.setTitleColor(.white, for: .normal)
    self.setTitleColor(UIColor.white.withAlphaComponent(0.2), for: .disabled)
    self.setBackgroundColor(color: Color.buttonGray, forState: .disabled)
    self.setBackgroundColor(color: Color.immutableOrange, forState: .normal)

    self.layer.cornerRadius = 6
    self.clipsToBounds = true
  }
}
