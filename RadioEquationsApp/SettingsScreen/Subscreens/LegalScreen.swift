//
//  LegalScreen.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 7/17/23.
//

import UIKit

class LegalScreen: UIViewController {
    
    var viewModel: LegalScreenVM? {
        didSet {
            self.title = viewModel?.screenTitle
            
            privacyPolicyTitleLabel.text = viewModel?.privacyPolicyTitle
            privacyPolicyTextView.text = viewModel?.privacyPolicy
            
            eulaTitleLabel.text = viewModel?.eulaTitle
            eulaTextView.text = viewModel?.eula
        }
    }
    
    
    private lazy var privacyPolicyTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Theme.textColor
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var privacyPolicyTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .Theme.backgroundColor
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .Theme.textColor
        return textView
    }()
    
    private lazy var eulaTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Theme.textColor
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var eulaTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .Theme.backgroundColor
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .Theme.textColor
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Theme.backgroundColor
        
        configureView()
    }
    
    private func configureView() {
        view.addSubview(privacyPolicyTitleLabel)
        view.addSubview(privacyPolicyTextView)
        
        let screenHeight = UIScreen.main.bounds.height
        
        privacyPolicyTitleLabel.centerX(inView: self.view)
        privacyPolicyTitleLabel.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, paddingTop: 16)
        
        privacyPolicyTextView.centerX(inView: self.view)
        privacyPolicyTextView.anchor(top: privacyPolicyTitleLabel.bottomAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, right: self.view.safeAreaLayoutGuide.rightAnchor, paddingTop: 16, paddingLeft: 8, paddingRight: 8, height: screenHeight * 0.4)
        
        view.addSubview(eulaTitleLabel)
        view.addSubview(eulaTextView)
       
        eulaTitleLabel.centerX(inView: self.view)
        eulaTitleLabel.anchor(top: privacyPolicyTextView.bottomAnchor, paddingTop: 16)
        
        eulaTextView.centerX(inView: self.view)
        eulaTextView.anchor(top: eulaTitleLabel.bottomAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.safeAreaLayoutGuide.rightAnchor, paddingTop: 16, paddingLeft: 8, paddingRight: 8)
        
    
        
    }
}
