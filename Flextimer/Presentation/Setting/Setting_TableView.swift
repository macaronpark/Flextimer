//
//  Setting_TableView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

extension SettingViewController: UITableViewDelegate {
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt
    indexPath: IndexPath)
  {

    switch (indexPath.section, indexPath.row) {
    case (2, 0):
        if let url = URL(string: "https://itunes.apple.com/app/id1484457501") {
          UIApplication.shared.open(url)
      }
      
    case (2, 1):
      if let url = URL(string: "https://github.com/macaronpark") {
        UIApplication.shared.open(url)
      }
      
    case (2, 2):
      if let url = URL(string: "https://www.notion.so/Opensources-5f23792b38334a17b6795a00dc20de7b") {
        UIApplication.shared.open(url)
      }
      
    default:
      break
    }
  }
}

extension SettingViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 48
  }
  
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
