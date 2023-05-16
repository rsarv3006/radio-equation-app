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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "equationCell", for: indexPath) as! HomeScreenEquationCell
        cell.viewModel = HomeScreenEquationCellViewModel(equationTitle: "Ohm's Law", id: "ohmsLaw")
        return cell
    }


}

extension ViewController: UITableViewDelegate {

}

