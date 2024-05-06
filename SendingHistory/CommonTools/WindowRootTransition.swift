//
//  WindowRootTransition.swift
//  DemoExample
//
//  Created by admin on 09.04.2024.
//

import Foundation
import UIKit

open class WindowRootTransition: NSObject, Transition {
    public var viewController: UIViewController?
    
    public func open(_ viewController: UIViewController) {
        guard let window = UIApplication.shared.windows.first else { return }
        window.rootViewController = UINavigationController(rootViewController: viewController)
        if !window.isKeyWindow {
            window.makeKeyAndVisible()
        }
    }
    
    public func close(_ viewController: UIViewController, animated: Bool?) {
        
    }
    
    
}
