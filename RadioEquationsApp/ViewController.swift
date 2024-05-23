import UIKit
import Combine

class ViewController: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .Theme.backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(HomeScreenEquationCell.self, forCellReuseIdentifier: "equationCell")
        tableView.rowHeight = 54
        
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfPurchasesHaveBeenMade()
        
        self.navigationItem.title = "Radio Equations"
        view.addSubview(tableView)
        tableView.fillSuperview()
        
        let barButtonItemImage = UIImage(systemName: "gear.circle")?.withTintColor(.Theme.altColor, renderingMode: .alwaysOriginal)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: barButtonItemImage, style: .plain, target: self, action: #selector(onSettingsTapped))
        
        store.$hasPurchasedUnlockAdvancedEquations.sink { [weak self] hasPurchased in
            if hasPurchased {
                self?.tableView.reloadData()
                
            }
        }.store(in: &subscriptions)
    }
    
    @objc func onSettingsTapped() {
        let settingsVc = SettingsScreen()
        let vm = SettingsViewModel()
        settingsVc.viewModel = vm
        
        navigationController?.pushViewController(settingsVc, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return EquationsTableInfo.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerTitle = EquationsTableInfo[section].title
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let label = UILabel(frame: CGRect(x: 15, y: 5, width: tableView.frame.width, height: 20))
        label.text = headerTitle
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .Theme.textColor
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EquationsTableInfo[section].equations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "equationCell", for: indexPath) as! HomeScreenEquationCell
        
        cell.viewModel = HomeScreenEquationCellViewModel(equation: EquationsTableInfo[indexPath.section].equations[indexPath.row], hasPurchasedUnlockAdvancedEquations: store.hasPurchasedUnlockAdvancedEquations)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let equationData = EquationsTableInfo[indexPath.section].equations[indexPath.row]
        
        if equationData.filters.contains(.advancedFunctions) && !store.hasPurchasedUnlockAdvancedEquations {
            showMessage(withTitle: "Equation Locked", message: "Please visit the Settings Screen to unlock Advanced Functions.")
            return nil
        }
        
        let equationScreen = EquationScreenTabBar(viewModel: EquationScreenTabBarViewModel(equation: EquationsTableInfo[indexPath.section].equations[indexPath.row]))
        
        self.navigationController?.pushViewController(equationScreen, animated: true)
        
        return nil
    }
}

extension ViewController: UITableViewDelegate {
    private func checkIfPurchasesHaveBeenMade() {
        Task {
            showLoader(true)
            await store.updateCustomerProductStatus()
            showLoader(false)
        }
    }
}
