//
//  Coordinator.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import Foundation

public protocol CoordinatorProtocol: class {
    func start()
}

open class Coordinator: CoordinatorProtocol {
    open func start() {}
}
