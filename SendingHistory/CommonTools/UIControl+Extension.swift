//
//  UITextField+Extension.swift
//  SSP
//
//  Created by Admin on 27.01.2022.
//

import Foundation
import UIKit
import PinLayout

typealias VoidBlock = (() -> Void)
typealias BoolBlock = ((Bool) -> Void)

private extension CGFloat {
    static let hSpacing: CGFloat = 15
    static let vSpacing: CGFloat = 8
    static let textFieldHeight: CGFloat = 45
    static let buttonHeight: CGFloat = 50
    static let cornerRadius: CGFloat = 4
    static let buttonCorner: CGFloat = 14
    static let spacing: CGFloat = 20
    static let bigVSpacing: CGFloat = 55
}

class ClosureButton: UIButton {
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(_touchUpInside), for: .touchUpInside)
        addSubview(activityIndicator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let label = titleLabel {
            activityIndicator.pin
                .right(of: label, aligned: .center)
                .marginLeft(.hSpacing)
                .right(.hSpacing)
                .sizeToFit()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var touchUpInside: VoidBlock? = nil
    
    var isLoading = true {
        didSet {
            isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
    
    @IBAction private func _touchUpInside() {
        touchUpInside?()
    }
    
    private var initialBackgroundColor: UIColor?
    override var backgroundColor: UIColor? {
        didSet {
            if initialBackgroundColor == nil {
                initialBackgroundColor = backgroundColor
            }
        }
    }
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? initialBackgroundColor : initialBackgroundColor?.withAlphaComponent(0.5)
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = !isHighlighted ? initialBackgroundColor : initialBackgroundColor?.withAlphaComponent(0.3)
        }
    }
}

class ClosureSwitch: UISwitch {
    var stateChanged: BoolBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction private func valueChanged() {
        stateChanged?(isOn)
    }
}

class ClosureTextField: UITextField {
    var editingDidBegin: VoidBlock? = nil
    var editingDidEnd: VoidBlock? = nil
    var valueChanged: ((String) -> Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(_editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(_editingDidEnd), for: .editingDidEnd)
        addTarget(self, action: #selector(_valueChanged), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBAction
    private func _editingDidBegin() {
        editingDidBegin?()
    }

    @IBAction
    private func _editingDidEnd() {
        editingDidEnd?()
    }

    @IBAction
    private func _valueChanged() {
        valueChanged?(text ?? "")
    }
}
