//
//  HistoryDetail_TableView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/21.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

extension HistoryDetailViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return self.viewModel?.sections[section].headerHeight ?? 0
  }

  func tableView(
    _ tableView: UITableView,
    didSelectRowAt
    indexPath: IndexPath
  ) {
    
    if (indexPath.section == 2) {
      let vc = DetailMemoViewController()
      self.navigationController?.pushViewController(vc, animated: true)
      return
    }
    
    let pickerMode: UIDatePicker.Mode = (indexPath == .init(row: 0, section: 1) ? .date: .time)
    let isStart = (indexPath.section == 0)
    let current: Date = (isStart ? self.workRecord?.startDate: self.workRecord?.endDate) ?? Date()
    let minForEndDate: Date? = isStart ? nil: self.workRecord?.startDate
    
    if (self.workRecord?.endDate == nil && !isStart) {
      return
    }
    
    weak var weakSelf = self

    DatePickerViewController.date(
      parent: weakSelf,
      current: current,
      min: minForEndDate,
      mode: pickerMode,
      doneButtonTitle: "기록 변경"
    ).subscribe(onNext: { [weak self] date in
      guard let self = self else { return }
      
      let workRecord = RealmService.shared.realm
        .objects(WorkRecord.self)
        .filter { $0.id == self.workRecord?.id ?? ""}
        .last
      
      if let workRecord = workRecord {
        let key = (isStart ? "startDate": "endDate")
        RealmService.shared.update(workRecord, with: [key: date])
      }
      
      DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
        self.tableView.reloadData()
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
      }
    }).disposed(by: self.disposeBag)
  }
}

extension HistoryDetailViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return self.viewModel?.sections.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.viewModel?.sections[section].sectionTitle
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
    let cell = tableView.dequeueCell(ofType: HistoryDetailTableViewCell.self, indexPath: indexPath)
    cell.updateCell(self.viewModel?.sections[indexPath.section].rows[indexPath.row] ?? HistoryDetailCellModel(""))
    return cell
  }
}
