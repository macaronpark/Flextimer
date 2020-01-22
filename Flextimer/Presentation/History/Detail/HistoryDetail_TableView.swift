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
    var vc: UIViewController = UIViewController()
    
    switch (indexPath.section, indexPath.row) {
    case (0, 1):
      vc = HistoryHourPickerViewController(self.workRecord?.startDate ?? Date())
      self.presentViewController(vc)
      
//    case (1, 0):
      
    case (1, 1):
      vc = HistoryHourPickerViewController(self.workRecord?.endDate ?? Date())
      self.presentViewController(vc)
      
    default:
      break
    }
  }
  
  func presentViewController(_ vc: UIViewController) {
    vc.modalPresentationStyle = .overFullScreen
    vc.modalTransitionStyle = .crossDissolve
    
    DispatchQueue.main.async {
      self.present(vc, animated: true, completion: nil)
    }
  }
}

extension HistoryDetailViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.viewModel?.sections.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.viewModel?.sections[section].sectionTitle
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return self.viewModel?.sections[section].headerHeight ?? 0
  }
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection
    section: Int
  ) -> Int {
    return self.viewModel?.sections[section].rows.count ?? 0
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt
    indexPath: IndexPath) -> UITableViewCell
  {
    if (indexPath.section == 2) {
      let cell = tableView.dequeueCell(ofType: HistoryDetailHolidayTableViewCell.self, indexPath: indexPath)
      cell.updateCell(self.viewModel?.sections[indexPath.section].rows[indexPath.row] ?? HistoryDetailCellModel(""))
      return cell
    }
    
    if (indexPath.section == 3) {
      let cell = tableView.dequeueCell(ofType: HistoryDetailDeleteTableViewCell.self, indexPath: indexPath)
      cell.updateCell(self.viewModel?.sections[indexPath.section].rows[indexPath.row] ?? HistoryDetailCellModel(""))
      return cell
    }
    
    let cell = tableView.dequeueCell(ofType: HistoryDetailTableViewCell.self, indexPath: indexPath)
    cell.updateCell(self.viewModel?.sections[indexPath.section].rows[indexPath.row] ?? HistoryDetailCellModel(""))
    return cell
  }
}
