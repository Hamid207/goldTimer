//
//  TimerDetailViewController.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

final class TimerDetailViewController: UIViewController {
    
    var viewModel: TimerDetailViewModelProtocol?
    
    var timerDetailTableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        guard let name = viewModel?.dataStore?.timerArray?[(viewModel?.index)!].name else { return }
        navigationItem.title = String(describing: name) + " statistics"
        self.navItems()
        self.itemSetup()
        viewModel?.statisticsStart()
    }

}
