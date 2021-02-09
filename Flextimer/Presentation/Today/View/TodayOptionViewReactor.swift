//
//  TodayOptionViewReactor.swift
//  Flextimer
//
//  Created by Macaron Park on 2021/02/09.
//  Copyright © 2021 Suzy Mararon Park. All rights reserved.
//

import Foundation

import ReactorKit
import RxSwift

class TodayOptionViewReactor: Reactor {
    
    enum Action {
        case load
    }
    
    enum Mutation {
        case updateHourText(String)
        case updateMinuteText(String)
        case updateWorkdayText(String)
        case updateWorkhourText(String)
    }
    
    struct State {
        var hourText: String?
        var minuteText: String?
        var workdayText: String?
        var workhourText: String?
    }
    
    var provider: ManagerProviderType
    
    var initialState: State = .init()
    
    init(_ provider: ManagerProviderType) {
        self.provider = provider
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            let userInfo = self.provider.userManager.userInfo
            
            return .concat([
                .just(.updateHourText(self.textualize(userInfo, type: .hour))),
                .just(.updateMinuteText(self.textualize(userInfo, type: .minute))),
                .just(.updateWorkdayText(self.textualize(userInfo, type: .workday))),
                .just(.updateWorkhourText(self.textualize(userInfo, type: .workhour))),
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .updateHourText(let text):
            state.hourText = text
            
        case .updateMinuteText(let text):
            state.minuteText = text
            
        case .updateWorkdayText(let text):
            state.workdayText = text
            
        case .updateWorkhourText(let text):
            state.workhourText = text
        }
        return state
    }
}


// MARK: - Method

extension TodayOptionViewReactor {
    
    fileprivate func textualize(_ info: UserInfo, type: TextualizeType) -> String {
        switch type {
        case .hour:
            return "Day: %dhrs".localized(with: [info.hourOfWorkhoursADay])
            
        case .minute:
            if (info.minuteOfWorkhoursADay == 0) {
                return ""
            }
            return " %dmin".localized(with: [info.minuteOfWorkhoursADay])
            
        case .workday:
            return "Week: %ddays".localized(with: [info.workdaysPerWeekIdxs.count])
            
        case .workhour:
            let workhourPerWeek = self.totalWorkhoursString(info)
            return workhourPerWeek
        }
    }
    
    fileprivate func totalWorkhoursString(_ info: UserInfo) -> String {
        let hour = info.hourOfWorkhoursADay
        let minute = info.minuteOfWorkhoursADay
        let numberOfWorkdays = info.workdaysPerWeekIdxs.count
        
        let multipledHour = hour * numberOfWorkdays
        let multipledMinute = minute * numberOfWorkdays
        
        let shareOfmultipledMinute: Int = multipledMinute / 60
        let restOfmultipledMinute: Int = multipledMinute % 60
        
        let hourResult: Int = multipledHour + shareOfmultipledMinute
        let minuteResult: Int = restOfmultipledMinute
        
        if minute == 0 {
            return "Based on %dhrs".localized(with: [hourResult])
        }
        return "Total: %dhrs %dmin".localized(with: [hourResult, minuteResult])
    }
}


// MARK: - Enum

extension TodayOptionViewReactor {
    
    enum TextualizeType {
        case hour
        case minute
        case workday
        case workhour
    }
}
