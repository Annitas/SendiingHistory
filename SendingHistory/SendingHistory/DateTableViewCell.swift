import UIKit
import PinLayout


struct DateViewModel {
    let date: String
}
final class DateTableViewCell: UITableViewCell {
    var viewModel: DateViewModel = DateViewModel(date: "") {
        didSet {
            dateLabel.text = viewModel.date
            dateLabel.sizeToFit()
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    let externalView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    let innerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.darkGray.cgColor
        return view
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(externalView)
        externalView.addSubview(innerView)
        innerView.addSubview(dateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureSubviews()
    }
    private func configureSubviews() {
        externalView.pin
            .all(.padding)
            .height(50)
        
        
        innerView.pin
            .all(.padding)
            .height(45)
        
        dateLabel.pin
            .vCenter()
            .end(15)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = size
        contentView.pin.width(size.width)
        configureSubviews()
        size.height = externalView.frame.maxY + .padding
        
        return size
    }
}

private extension CGFloat {
    static var padding: CGFloat = 8
}
