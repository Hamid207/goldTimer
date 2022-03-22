//
//  TimerDetailViewController+Extension.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

extension TimerDetailViewController {
    func navItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(popVC))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    @objc private func popVC() {
        viewModel?.popVC()
    }
    
 
    
    func itemSetup() {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus")
//                                                            , style: .done, target: self, action: #selector(addVC))
        timerDetailTableView.delegate = self
        timerDetailTableView.dataSource = self
        timerDetailTableView.register(TimerDetailTableView.self, forCellReuseIdentifier: "TimerDetailTableViewId")
        timerDetailTableView.allowsSelection = false // tableViewnu basmaq olmur
        timerDetailTableView.backgroundColor = .white
//        tableView.tableHeaderView = UIView()
        timerDetailTableView.tableFooterView = UIView()
        timerDetailTableView.separatorStyle = .none
        view.addSubview(timerDetailTableView)
        timerDetailTableView.translatesAutoresizingMaskIntoConstraints = false
        timerDetailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        timerDetailTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        timerDetailTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        timerDetailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension TimerDetailViewController: PushTimerDetailVCDelegate {
    func timerStartDelegate(index: Int?, startPauseBool: Bool, bugFixBool: Bool?, secondTimerDontStart: Bool?) {
        DispatchQueue.main.async {
            self.viewModel?.startPauseBool = startPauseBool
    //        viewModel?.index = index
            self.viewModel?.sendAction(startPauseBool: startPauseBool)
        }
    }
}

extension TimerDetailViewController: SentTimerStatisticDelegate {
    func sentTimerStatisticDelegate(days: TimerStatisticsEnum) {
        viewModel?.sentTimerStatistics(days: days, tableView: timerDetailTableView)
    }
}

extension TimerDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimerDetailTableViewId", for: indexPath) as! TimerDetailTableView
        cell.pushhDelegate = self
        cell.timerStatisticsDelegate = self
        cell.index = indexPath.row
//        let index = (viewModel?.index)!
//        let item = viewModel?.model?[index]
        cell.update(statisticsTime: viewModel?.statisticsTime, timeArray: (viewModel?.timeDayArray)!, timerTime: viewModel?.timerTime ?? 0, userTarget: viewModel?.userTagret ?? 0, timerDone: viewModel?.timerDone ?? 0)
        return cell
    }
}

extension TimerDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.frame.height)
    }
}
