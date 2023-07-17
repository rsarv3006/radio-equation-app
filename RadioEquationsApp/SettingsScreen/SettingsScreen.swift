//
//  SettingsScreen.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 7/16/23.
//

import UIKit

class SettingsScreen: UIViewController {
   
    var viewModel: SettingsViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            self.title = viewModel.screenTitle
            self.appVersionLabel.text = viewModel.appVersion
        }
    }
   
    private lazy var contactSupportButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Contact Support", for: .normal)
        button.addTarget(self, action: #selector(onContactSupportTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        return button
    }()
    
    private lazy var appVersionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureView()
    }
    
    private func configureView() {
        view.addSubview(contactSupportButton)
        contactSupportButton.centerX(inView: self.view)
        contactSupportButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        
        view.addSubview(appVersionLabel)
        appVersionLabel.centerX(inView: self.view)
        appVersionLabel.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    @objc func onContactSupportTapped() {
        let urlString = "mailto:\(supportEmail)?subject=Support Request"
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
