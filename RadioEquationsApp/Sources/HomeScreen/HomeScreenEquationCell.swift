import RichTextView
import UIKit

class HomeScreenEquationCell: UITableViewCell {
    var viewModel: HomeScreenEquationCellViewModel? {
        didSet { onViewModelDidSet() }
    }

    private lazy var equationLabel: RichTextView = {
        let richTextView = RichTextView(
            input: "",
            latexParser: LatexParser(),
            font: UIFont.systemFont(ofSize: 18),
            textColor: UIColor.Theme.textColor,
            latexTextBaselineOffset: 6,
            frame: CGRect.zero,
            completion: nil
        )

        return richTextView
    }()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .Theme.backgroundColor

        addSubview(equationLabel)
        equationLabel.centerY(inView: self)
        equationLabel.anchor(left: leftAnchor, paddingLeft: 32, paddingBottom: 8)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - ViewModel handlers

extension HomeScreenEquationCell {
    func onViewModelDidSet() {
        guard let viewModel = viewModel else { return }
        var textColor = UIColor.Theme.textColor

        if viewModel.isLocked {
            textColor = .systemGray
        }

        equationLabel.update(input: viewModel.equationTitle, textColor: textColor)
    }
}
