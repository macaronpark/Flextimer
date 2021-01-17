//
//  ManagerProvider.swift
//  Flextimer
//
//  Created by Macaron Park on 2021/01/17.
//  Copyright © 2021 Suzy Mararon Park. All rights reserved.
//

import Foundation

protocol ManagerProviderType: class {
    var userManager: UserManagerType { get }
}

final class ManagerProvider: ManagerProviderType {
    lazy var userManager: UserManagerType = UserManager(provider: self)
}
