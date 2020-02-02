//
//  Setting_TableView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RxCocoa

extension SettingViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 48
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
    
    if indexPath.section == 2, indexPath.row == 3 {
      let tutorialVC = TutorialPageViewController()
      tutorialVC.modalPresentationStyle = .fullScreen
      self.present(tutorialVC, animated: true, completion: nil)
    }
  }
}

extension SettingViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return self.viewModel.sections.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let title = ["일일 근무 시간", "주간 근무 요일", "기타"]
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
