//
//  TodayViewReactor.swift
//  Flextimer
//
//  Created by Macaron Park on 2021/02/10.
//  Copyright © 2021 Suzy Mararon Park. All rights reserved.
//

import ReactorKit

class TodayViewReactor: Reactor {
    
    typealias Action = NoAction
    
    typealias Mutation = NoMutation
    
    struct State {}
    
    var initialState: State = .init()
    
    let provider: ManagerProviderType
    
    
    // MARK: - Init
    
    init(_ provider: ManagerProviderType) {
        self.provider = provider
    }
}


// MARK: - Reactors

extension TodayViewReactor {
    
    func reactorForOptionView() -> TodayOptionViewReactor {
        return TodayOptionViewReactor(self.provider)
    }
}
