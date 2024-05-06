//
//  Router.swift
//  BytepaceSwiftUtils
//
//  Created by Ruslan Musagitov on 13.10.2020.
//  Copyright © 2020 Ruslan Musagitov. All rights reserved.
//

import Foundation
import UIKit

public protocol Closable: AnyObject {
    func close(_ animated: Bool)
}

public protocol RouterProtocol: AnyObject {
    associatedtype ViewController: UIViewController
    var viewController: ViewController? { get }
    
    func open(_ viewController: UIViewController, transition: Transition)
    func openWithNextRouter<U: UIViewController>(_ viewController: UIViewController, nextRouter: Router<U>, transition: Transition)
    func close(_ animated: Bool)
}

open class Router<RouterViewController>: RouterProtocol, Closable where RouterViewController: UIViewController {
    public typealias ViewController = RouterViewController

    weak public var viewController: ViewController?
    public var openTransition: Transition?

    public init() {}

    public func open(_ viewController: UIViewController, transition: Transition) {
        transition.viewController = self.viewController
        transition.open(viewController)
    }

    public func openWithNextRouter<UI: UIViewController>(_ viewController: UIViewController, nextRouter: Router<UI>, transition: Transition) {
        nextRouter.openTransition = transition
        open(viewController, transition: transition)
    }
    
    public func close(_ animated: Bool = true) {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        openTransition.close(viewController, animated: animated)
    }
    
    public func closeChilds() {
        if let openTransition = openTransition as? PushTransition {
            openTransition.closeChilds()
        } else if let vc = self.viewController, let navVC = vc.navigationController {
            navVC.popToViewController(vc, animated: true)
        }
    }
    
    public func closeCurrentModalPresentation(_ animated: Bool = true) {
        viewController?.dismiss(animated: animated, completion: nil)
    }
}
