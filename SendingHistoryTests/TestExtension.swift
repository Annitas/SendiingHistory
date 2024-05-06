//
//  TestExtension.swift
//  
//
//  Created by Anita Stashevskaya on 06.05.2024.
//

import Foundation
import UIKit

extension UIView {
    func renderOnWindow(size: CGSize = CGSize(width: 375, height: 667)) {
        let window = UIWindow(frame: CGRect(origin: .zero, size: size))
        window.addSubview(self)
        frame = window.bounds
        setNeedsLayout()
        layoutIfNeeded()
    }
}

extension UIViewController {
    func renderOnWindow(size: CGSize? = nil) {
        loadViewIfNeeded()

        let window = UIWindow(frame: size != nil ? CGRect(origin: .zero, size: size!) : UIScreen.main.bounds)
        window.rootViewController = self
        window.addSubview(view)
        view.frame = window.bounds
        view.layoutIfNeeded()
    }
}
