//
//  HistoryDetail_TableView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/21.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

extension HistoryDetailViewController: UITableViewDelegate {
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt
    indexPath: IndexPath)
  {
    
  }
}

extension HistoryDetailViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return "출근"
      
    case 1:
      return "퇴근"
      
    default:
      return " "
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 60
  }
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection
    section: Int
  ) -> Int {
    if section == 2 {
      return 1
    }
    return 2
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt
    indexPath: IndexPath) -> UITableViewCell
  {
    if indexPath.section == 2 {
      let cell = tableView.dequeueCell(ofType: HistoryDetailDeleteTableViewCell.self, indexPath: indexPath)
      return cell
    }
    
    let cell = tableView.dequeueCell(ofType: HistoryDetailTableViewCell.self, indexPath: indexPath)
    cell.updateCell(self.workRecord ?? WorkRecord(), indexPath: indexPath)
    return cell
  }
}
