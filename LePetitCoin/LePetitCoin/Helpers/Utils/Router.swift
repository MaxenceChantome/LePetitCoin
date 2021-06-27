//
//  Router.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import Foundation
import UIKit

protocol RouterType {
    func present(_ controller: UIViewController, animated: Bool)
    func dismiss(animated: Bool)
    
    func push(_ controller: UIViewController, animated: Bool)
    func pop(animated: Bool)
}

final class Router: RouterType {
    private weak var rootController: UINavigationController?
    
    public init(rootController: UINavigationController) {
        self.rootController = rootController
        self.rootController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    public func present(_ controller: UIViewController, animated: Bool) {
        controller.modalPresentationStyle = .overFullScreen
        rootController?.present(controller, animated: animated, completion: nil)
    }

    public func push(_ controller: UIViewController, animated: Bool) {
        rootController?.pushViewController(controller, animated: animated)
    }
    
    
    public func pop(animated: Bool) {
        rootController?.popViewController(animated: animated)
    }
    
    public func dismiss(animated: Bool) {
        rootController?.dismiss(animated: animated, completion: nil)
    }
    
}
