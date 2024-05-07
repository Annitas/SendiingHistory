
import Foundation
import UIKit

struct SendingHistoryViewModel {
    let dates: [DateViewModel]
}

final class SendingHistoryViewController: UIViewController {
    var presenter: SendingHistoryPresenter? {
        didSet {
            guard let presenter else { return }
            viewModel = presenter.output.viewModel
            presenter.outputChanged = { [weak self] in
                self?.viewModel = presenter.output.viewModel
            }
        }
    }
    
    var viewModel: SendingHistoryViewModel = SendingHistoryViewModel(dates: []) {
        didSet {
            tableView.reloadData()
        }
    }

    let tableView: UITableView = .init()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DateTableViewCell.self, 
                           forCellReuseIdentifier: String(describing: DateTableViewCell.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        configureSubviews()
    }
    
    private func configureSubviews() {
        tableView.pin
            .all()
    }
}

extension SendingHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DateTableViewCell.self), for: indexPath) as! DateTableViewCell
        cell.viewModel = viewModel.dates[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dates.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.input.dateSelected?(indexPath.row)
    }
}
