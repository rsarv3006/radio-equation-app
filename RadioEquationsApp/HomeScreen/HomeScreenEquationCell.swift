//
// Created by Robert J. Sarvis Jr on 5/15/23.
//

import UIKit

class HomeScreenEquationCell: UITableViewCell {
    var viewModel: HomeScreenEquationCellViewModel? {
        didSet { onViewModelDidSet() }
    }

    private lazy var equationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)

        return label
    }()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(equationLabel)
        equationLabel.centerY(inView: self)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - ViewModel handlers
extension HomeScreenEquationCell {
    func onViewModelDidSet() {
        guard let viewModel = viewModel else { return }
        equationLabel.text = viewModel.equationTitle
    }
}
