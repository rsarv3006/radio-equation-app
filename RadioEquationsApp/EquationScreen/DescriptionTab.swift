//
//  DescriptionTab.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/17/23.
//

import UIKit

class DescriptionTab: UIViewController {
    
    var viewModel: DescriptionTabViewModel? {
        didSet {
            descriptionTextView.text = viewModel?.equation.description
            
        }
    }
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(descriptionTextView)
        descriptionTextView.fillSuperview()
    }
}
