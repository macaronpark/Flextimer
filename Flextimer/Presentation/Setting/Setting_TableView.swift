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
    guard let nvc = self.navigationController,
      let action = self.viewModel.sections[indexPath.section].rows[indexPath.row].action else {
        return
    }
    
    action(nvc)
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
    return self.viewModel.sections[section].title
  }
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection
    section: Int
  ) -> Int {
    return self.viewModel.sections[section].rows.count
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt
    indexPath: IndexPath) -> UITableViewCell
  {
    let row = self.viewModel.sections[indexPath.section].rows[indexPath.row]
    
    switch row.component {
    case .indicator:
      let cell = tableView.dequeueCell(ofType: SettingBasicCell.self, indexPath: indexPath)
      cell.accessoryType = .disclosureIndicator
      cell.updateUI(row)
      return cell
      
    case .label:
      let cell = tableView.dequeueCell(ofType: SettingLabelCell.self, indexPath: indexPath)
      cell.updateUI(row)
      return cell
      
    case .none:
      let cell = tableView.dequeueCell(ofType: SettingBasicCell.self, indexPath: indexPath)
      cell.updateUI(row)
      return cell
    }
  }
}
