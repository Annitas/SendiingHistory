//

import UIKit

final class SendingDetailsView: UIView {
    // MARK: - UI Elements
    
    // MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
    }
}

// MARK: - Private Methods

extension SendingDetailsView {
    
    private func setupSubviews() {

    }
    
    private func configureSubviews() {

    }
}
