//
//  ViewController.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 5/15/23.
//

import UIKit

class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(HomeScreenEquationCell.self, forCellReuseIdentifier: "equationCell")

        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Radio Equations"
        view.addSubview(tableView)
        tableView.fillSuperview()
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return EquationsTableInfo.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerTitle = EquationsTableInfo[section].title
        
        let headerView = UILabel()
        headerView.text = headerTitle
        headerView.font = UIFont.boldSystemFont(ofSize: 20)
        return headerView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EquationsTableInfo[section].equations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "equationCell", for: indexPath) as! HomeScreenEquationCell
        cell.viewModel = HomeScreenEquationCellViewModel(equation: EquationsTableInfo[indexPath.section].equations[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let equationScreen = EquationScreenTabBar(viewModel: EquationScreenTabBarViewModel(equation: EquationList[indexPath.row]))
        
        self.navigationController?.pushViewController(equationScreen, animated: true)
        
        return nil
    }}

extension ViewController: UITableViewDelegate {

}

