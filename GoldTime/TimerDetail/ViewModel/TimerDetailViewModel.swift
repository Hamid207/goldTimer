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
    init(mainRouter: MainRouterProtocol?, dataStore: DataStoreProtocol?, index: Int, predicate: NSPredicate, timerStatistics: TimerStatistics?)
}

final class TimerDetailViewModel: TimerDetailViewModelProtocol {
    private let mainRouter: MainRouterProtocol?
    var dataStore: DataStoreProtocol?
    private let timerStatistics: TimerStatistics?
    var model: Results<TimerModelData>?
    var index: Int?
    var startPauseBool: Bool?
    var statisticsTime: Int?
    private var predicate: NSPredicate!
    init(mainRouter: MainRouterProtocol?, dataStore: DataStoreProtocol?, index: Int, predicate: NSPredicate, timerStatistics: TimerStatistics?) {
        self.mainRouter = mainRouter
        self.dataStore = dataStore
        self.index = index
        self.timerStatistics = timerStatistics
        self.predicate = predicate
        model = dataStore?.timerArray
        self.dataStore?.timerArray = realm.objects(TimerModelData.self).filter(predicate)
    }
   
    func sendAction(startPauseBool: Bool?) {
//        self.dataStore?.timerStart(index: self.index!, startPauseBool: startPauseBool, completion: { booll in
//        })
    }
    
    func popVC() {
        mainRouter?.popVC()
    }
    
    func sentTimerStatistics(days: TimerStatisticsEnum, tableView: UITableView) {
        statisticsTime = dataStore?.addStatistic(days: days, index: index, predicate: predicate)
        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
    
}
