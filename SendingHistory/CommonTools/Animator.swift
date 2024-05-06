//
//  Animatr.swift
//  SSP
//
//  Created by Admin on 27.01.2022.
//

import Foundation
import UIKit

public protocol Animator: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
