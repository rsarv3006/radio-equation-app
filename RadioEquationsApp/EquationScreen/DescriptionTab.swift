//
//  DescriptionTab.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/17/23.
//

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
            textColor: UIColor(named: "TextColor") ?? UIColor.black,
            frame: CGRect.zero,
            completion: nil
        )

        return richTextView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(descriptionTextView)
        descriptionTextView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor, paddingLeft: 8, paddingRight: 8)
    }
}
