//
//  TutorialViewModel.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/02/02.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import Foundation

class TutorialViewModel {
  let title: String
  let content: String
  let imageName: String
  let isLast: Bool
  
  init(_ title: String, content: String, imageName: String, isLast: Bool = false) {
    self.title = title
    self.content = content
    self.imageName = imageName
    self.isLast = isLast
  }
}
