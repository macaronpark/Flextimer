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
    
  }
}

extension HistoryViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 48
  }
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection
    section: Int
  ) -> Int {
    return 10
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt
    indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueCell(ofType: HistoryTableViewCell.self, indexPath: indexPath)
    cell.updateCell()
    return cell
  }
}
