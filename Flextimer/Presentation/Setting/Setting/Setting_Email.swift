//
//  Setting_Email.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/05/15.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit
import MessageUI

extension SettingViewController: MFMailComposeViewControllerDelegate {
  
  func mailComposeController(
    _ controller: MFMailComposeViewController,
    didFinishWith result: MFMailComposeResult,
    error: Error?
  ) {
    controller.dismiss(animated: true)
  }
}
