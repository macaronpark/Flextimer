//
//  WeekDetailViewModel.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/11/14.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import Combine

class WeekDetailViewModel: ObservableObject {

    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    var realmObject: WorkRecord = WorkRecord()

    let record = PassthroughSubject<WorkRecord, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        record.sink { (record) in
            self.startDate = record.date
            self.endDate = record.endDate ?? Date()
            self.realmObject = record
        }.store(in: &cancellables)
        
//        $startDate.sink { date in
//            // 🤢🤮
//            RealmService.shared.update(self.realmObject, with: ["date" : date])
//        }.store(in: &cancellables)
    }
    
    enum DateType {
        case start
        case end
    }
    
//    func updateDate(_ date: Date, dateType: DateType) {
//        let key = (dateType == .start) ? "date": "endDate"
//        let object = record.sen
//        RealmService.shared.update(object, with: [key : date])
//    }
}
