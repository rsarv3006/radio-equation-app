import UIKit
import RichTextView

class DescriptionTab: UIViewController {
    
    var viewModel: DescriptionTabViewModel? {
        didSet {
            descriptionTextView.update(input: viewModel?.equation.description)
        }
    }
    
    private lazy var descriptionTextView: RichTextView = {
        let richTextView = RichTextView(
            input: "",
            latexParser: LatexParser(),
            font: UIFont.systemFont(ofSize: 16),
            textColor: UIColor.Theme.textColor,
            frame: CGRect.zero,
            completion: nil
        )

        return richTextView
    }()
    
    private lazy var descriptionScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Theme.backgroundColor
        descriptionScrollView.addSubview(descriptionTextView)
        view.addSubview(descriptionScrollView)
        descriptionTextView.anchor(top: descriptionScrollView.topAnchor, left: self.view.leftAnchor, bottom: descriptionScrollView.bottomAnchor, right: self.view.rightAnchor, paddingLeft: 8, paddingRight: 8)
        
        descriptionScrollView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor)
    }
}
