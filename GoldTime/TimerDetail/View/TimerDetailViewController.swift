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
    
    var statisticsDateDays: [String]?
    var statisticsTimeDays: [Int]?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        guard let name = viewModel?.dataStore?.timerArray?[(viewModel?.index)!].name else { return }
        navigationItem.title = String(describing: name)
        viewModel?.tableView = timerDetailTableView
        self.navItems()
        self.itemSetup()
//        viewModel?.statisticsStart()
        viewModel?.sentDaysStatistics(completion: { [weak self] days, timerTIme in
            guard let  self = self else { return }
            self.statisticsDateDays?.removeAll()
            self.statisticsDateDays = days
            self.statisticsTimeDays = timerTIme
        })
    }

}
