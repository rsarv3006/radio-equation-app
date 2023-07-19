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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.Theme.altColor, for: .normal)
        return button
    }()
    
    private lazy var appVersionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Theme.textColor
        return label
    }()
    
    private lazy var legalButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Legal", for: .normal)
        button.addTarget(self, action: #selector(onLegalButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.Theme.altColor, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .Theme.backgroundColor
        self.navigationController?.navigationBar.tintColor = .Theme.altColor
        configureView()
    }
    
    private func configureView() {
        view.addSubview(contactSupportButton)
        contactSupportButton.centerX(inView: self.view)
        contactSupportButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        
        view.addSubview(appVersionLabel)
        appVersionLabel.centerX(inView: self.view)
        appVersionLabel.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
        view.addSubview(legalButton)
        legalButton.centerX(inView: self.view)
        legalButton.anchor(top: contactSupportButton.bottomAnchor, paddingBottom: 20)
        
    }
    
    @objc func onContactSupportTapped() {
        let urlString = "mailto:\(supportEmail)?subject=Support Request"
        
        guard let urlStringPercentEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                let url = URL(string: urlStringPercentEncoded) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func onLegalButtonTapped() {
        let screen = LegalScreen()
        let vm = LegalScreenVM()
        screen.viewModel = vm
        
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
