//
//  Setting_TableView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit
import MessageUI

import RxCocoa

extension SettingViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 48
  }
  
  func tableView(
    _ tableView: UITableView,
    willDisplayHeaderView view: UIView,
    forSection section: Int
  ) {
    if let headerView = view as? UITableViewHeaderFooterView {
      let text = headerView.textLabel?.text
      headerView.textLabel?.text = text?.capitalizingFirstLetter()
    }
  }
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt
    indexPath: IndexPath)
  {
    if (indexPath.section == 0) {
      DispatchQueue.main.async {
        let vc = WorkhoursADayViewController(RealmService.shared.userInfo)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.triggerImpact()
        self.navigationController?.present(vc, animated: true, completion: nil)
      }
    }

    if let url = SettingURLModel(indexPath).url {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    if indexPath.section == 2 {
      switch indexPath.row {
      case 2:
        if MFMailComposeViewController.canSendMail() {
          let mail = MFMailComposeViewController()
          mail.mailComposeDelegate = self
          mail.setToRecipients(["pxxxsxzy.0@gmail.com"])
          mail.setMessageBody("<p>\(Text.SVC_EMAIL)</p>", isHTML: true)
          present(mail, animated: true)
        }
        
      case 4:
        let tutorialVC = TutorialPageViewController()
        tutorialVC.modalPresentationStyle = .fullScreen
        self.present(tutorialVC, animated: true, completion: nil)
        
      default:
        break
      }
    }
  }
}

extension SettingViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return self.viewModel.sections.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let title = [Text.SVC_SECTION1, Text.SVC_SECTION2, Text.SVC_SECTION3]
    return title[section]
  }
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection
    section: Int
  ) -> Int {
    return self.viewModel.sections[section].count
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt
    indexPath: IndexPath) -> UITableViewCell
  {
    if (indexPath.section == 1) {
      let cell = tableView.dequeueCell(ofType: SettingDayNameCell.self, indexPath: indexPath)
      return cell
    }
    
    let cell = tableView.dequeueCell(ofType: SettingCell.self, indexPath: indexPath)
    cell.updateUI(self.viewModel.sections[indexPath.section][indexPath.row])
    return cell
  }
}
