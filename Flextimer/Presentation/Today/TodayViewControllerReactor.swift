//
//  TodayViewReactor.swift
//  Flextimer
//
//  Created by Macaron Park on 2021/02/09.
//  Copyright © 2021 Suzy Mararon Park. All rights reserved.
//

import Foundation

import ReactorKit

class TodayViewControllerReactor: Reactor {
    
    // TODO
    enum Action {
        case load
    }
    
    enum Mutation {
        case updateOptions
    }

    struct State {
        var isWorking: Bool
    }
    
    var initialState: State {
        return .init(isWorking: false)
    }
    
    let provider : ManagerProviderType
    
    init(provider: ManagerProviderType) {
        self.provider = provider
    }

}

extension TodayViewControllerReactor {
    
    func reactorForTodayView() -> TodayViewReactor {
        return TodayViewReactor(self.provider)
    }
}
