//
//  TimerDetailViewModel.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import Foundation
import RealmSwift

protocol TimerDetailViewModelProtocol {
    var index: Int? { get set }
    var model: Results<TimerModelData>? { get set }
    var startPauseBool: Bool? { get set }
    func sendAction(startPauseBool: Bool?)
    func popVC()
    func sentTimerStatistics(days: TimerStatisticsEnum, tableView: UITableView)
    var statisticsTime: Int? { get set }
    var dataStore: DataStoreProtocol? { get set }
    var timeDayArray: [Int]? { get set }
    func statisticsStart()
    var timerTime: Int? { get set }
    var userTagret: Int? { get set }
    var timerDone: Int? { get set }
    var timerColor: String? { get set }
    func restartUserTarget()
    var tableView: UITableView? { get set }
    init(mainRouter: MainRouterProtocol?, dataStore: DataStoreProtocol?, index: Int, predicate: NSPredicate)
}

final class TimerDetailViewModel: TimerDetailViewModelProtocol {
    private let mainRouter: MainRouterProtocol?
    var dataStore: DataStoreProtocol?
    var model: Results<TimerModelData>?
    var index: Int?
    var startPauseBool: Bool?
    var statisticsTime: Int?
    private var predicate: NSPredicate!
    var timeDayArray: [Int]?
    var timerTime: Int?
    var userTagret: Int?
    var timerDone: Int?
    var timerColor: String?
    var tableView: UITableView?
    
    init(mainRouter: MainRouterProtocol?, dataStore: DataStoreProtocol?, index: Int, predicate: NSPredicate) {
        self.mainRouter = mainRouter
        self.dataStore = dataStore
        self.index = index
        self.predicate = predicate
        self.dataStore?.timerArray = realm.objects(TimerModelData.self).filter(predicate)
        model = dataStore?.timerArray
//        timerTime = model?[index].timerTime
//        timerDone = model?[index].theTimerIsFinishedHowManyTimes
//        userTagret = model?[index].userTarget
//        timerColor = model?[index].timerColor
        reload()
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("timerDone"), object: nil)

    }
    
    @objc private func reload() {
        DispatchQueue.main.async { [ weak self ] in
            guard let self = self else { return }
            guard let index = self.index else { return }
            self.model = self.dataStore?.timerArray
            self.timerTime = self.model?[index].timerTime
            self.timerDone = self.model?[index].theTimerIsFinishedHowManyTimes
            self.userTagret = self.model?[index].userTarget
            self.timerColor = self.model?[index].timerColor
            self.statisticsStart()
            self.tableView?.reloadData()
        }
    }
   
    func statisticsStart() {
        statisticsTime = dataStore?.findOutStatistics(days: .week, index: index, predicate: predicate).0
        timeDayArray = dataStore?.findOutStatistics(days: .week, index: index, predicate: predicate).1
    }
    
    func sendAction(startPauseBool: Bool?) {
//        self.dataStore?.timerStart(index: self.index!, startPauseBool: startPauseBool, completion: { booll in
//        })
    }
    
    func restartUserTarget() {
        guard let index = index else { return }
        try! realm.write {
            dataStore?.timerArray?[index].theTimerIsFinishedHowManyTimes = 0
            timerDone = 0
        }
    }
    
    func popVC() {
        mainRouter?.popVC()
    }
    
    func sentTimerStatistics(days: TimerStatisticsEnum, tableView: UITableView) {
        statisticsTime = dataStore?.findOutStatistics(days: days, index: index, predicate: predicate).0
        timeDayArray = dataStore?.findOutStatistics(days: days, index: index, predicate: predicate).1
        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
    
}
