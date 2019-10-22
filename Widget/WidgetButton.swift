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

  enum WidgetButtonType {
    case start
    case end
    case done
    case cancel

    var title: String {
      switch self {
      case .start:
        return "출근"
      case .end:
        return "퇴근"
      case .done:
        return "확인"
      case .cancel:
        return "취소"
      }
    }
  }

  /// 버튼 타입 별 title, titleColor, backgroundColor 설정
  func setBasicConfig(_ type: WidgetButtonType) {
    self.setTitle(type.title, for: .normal)

    switch type {
    case .start, .end, .done:
      self.setTitleColor(.white, for: .normal)
      self.setTitleColor(UIColor.white.withAlphaComponent(0.2), for: .disabled)
      self.setBackgroundColor(color: AppColor.widgetGray, forState: .disabled)
      self.setBackgroundColor(color: AppColor.uiOrange, forState: .normal)
      
    default:
      self.setTitleColor(AppColor.uiOrange, for: .normal)
      self.setBackgroundColor(color: .white, forState: .normal)
    }

    self.layer.cornerRadius = 6
    self.clipsToBounds = true
  }
}
