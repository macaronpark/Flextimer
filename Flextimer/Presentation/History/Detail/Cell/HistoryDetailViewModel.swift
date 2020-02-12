//
//  HistoryDetailViewModel.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/21.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

class HistoryDetailCellModel {
  let title: String
  let isEditable: Bool?
  let isHoliday: Bool?
  let textColor: UIColor
  
  init(
    _ title: String,
    isEditable: Bool? = true,
    isHoliday: Bool? = false,
    textColor: UIColor = Color.primaryText
  ) {
    self.title = title
    self.isEditable = isEditable
    self.isHoliday = isHoliday
    self.textColor = textColor
  }
}

class HistoryDetailSectionModel {
  let sectionTitle: String?
  let rows: [HistoryDetailCellModel]
  let headerHeight: CGFloat
  
  init(
    _ rows: [HistoryDetailCellModel],
    sectionTitle: String? = nil,
    headerHeight: CGFloat = 60
  ) {
    self.rows = rows
    self.sectionTitle = sectionTitle
    self.headerHeight = headerHeight
  }
}

class HistoryDetailViewModel {
  let sections: [HistoryDetailSectionModel]
  
  init(_ workRecord: WorkRecord) {
    // 출근
    let startRows: [HistoryDetailCellModel] = [
      HistoryDetailCellModel(
        Formatter.dayName.string(from: workRecord.startDate),
        isEditable: false,
        isHoliday: workRecord.isHoliday,
        textColor: Color.secondaryText
      ),
      HistoryDetailCellModel(
        Formatter.shm.string(from: workRecord.startDate).replacingOccurrences(of: " 0분", with: ""),
        isHoliday: workRecord.isHoliday
      )
    ]
    
    // 퇴근
    var endRows: [HistoryDetailCellModel] = []
    
    if workRecord.endDate != nil {
      endRows = [
        HistoryDetailCellModel(
          Formatter.dayName.string(from: workRecord.endDate ?? Date()),
          isHoliday: workRecord.isHoliday,
          textColor: Color.secondaryText
        ),
        HistoryDetailCellModel(
          Formatter.shm.string(from: workRecord.endDate ?? Date()).replacingOccurrences(of: " 0분", with: ""),
          isHoliday: workRecord.isHoliday
        )
      ]
    } else {
      endRows = [
        HistoryDetailCellModel("", isEditable: false),
        HistoryDetailCellModel("", isEditable: false)
      ]
    }
    
    // 적바림
    var memoText = "등록된 내용 없음"
    var memoColor = UIColor.quaternaryLabel
    
    if let memo = workRecord.memo, memo.count > 0 {
      memoText = memo
      memoColor = Color.secondaryText
    }

    let memoRows = [
      HistoryDetailCellModel(memoText, isEditable: true, textColor: memoColor)
    ]

    let startSection = HistoryDetailSectionModel(startRows, sectionTitle: "출근")
    let endSection = HistoryDetailSectionModel(endRows, sectionTitle: "퇴근")
    let memoSection = HistoryDetailSectionModel(memoRows, sectionTitle: "적바림")

    self.sections = [
      startSection,
      endSection,
      memoSection
    ]
  }
}
