//
// Created by Robert J. Sarvis Jr on 5/15/23.
//

import UIKit
import RichTextView

class HomeScreenEquationCell: UITableViewCell {
    var viewModel: HomeScreenEquationCellViewModel? {
        didSet { onViewModelDidSet() }
    }

    private lazy var equationLabel: RichTextView = {
        
        let richTextView = RichTextView(
            input: "",
            latexParser: LatexParser(),
            font: UIFont.systemFont(ofSize: UIFont.systemFontSize),
            textColor: UIColor(named: "TextColor") ?? UIColor.black,
            frame: CGRect.zero,
            completion: nil
        )

        return richTextView
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
        equationLabel.update(input: viewModel.equationTitle)
        
    }
}
