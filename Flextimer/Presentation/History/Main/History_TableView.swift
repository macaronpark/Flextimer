//
//  History_TableView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

extension HistoryViewController: UITableViewDelegate {
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt
    indexPath: IndexPath)
  {
    if let workRecord = self.historyViewModel?.sections[indexPath.section].rows[indexPath.row].workRecord {
      let vc = HistoryDetailViewController(workRecord)
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
}

extension HistoryViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 52
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.historyViewModel?.sections.count ?? 0
  }
  
//  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//    return 40
//  }
//
//  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//    return "총 근무 시간"
//  }
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection
    section: Int
  ) -> Int {
    return self.historyViewModel?.sections[section].rows.count ?? 0
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt
    indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueCell(ofType: HistoryTableViewCell.self, indexPath: indexPath)
    if let model = self.historyViewModel?.sections[indexPath.section].rows[indexPath.row] {
      cell.updateCell(model)
    }
    return cell
  }
}
