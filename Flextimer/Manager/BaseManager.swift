//
//  BaseManager.swift
//  Flextimer
//
//  Created by Macaron Park on 2021/01/17.
//  Copyright © 2021 Suzy Mararon Park. All rights reserved.
//

import Foundation

class BaseManager {
    
    unowned let provider: ManagerProviderType
    
    init(provider: ManagerProviderType) {
        self.provider = provider
    }
}
