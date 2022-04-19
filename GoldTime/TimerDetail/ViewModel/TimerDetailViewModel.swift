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
    func sentDaysStatistics(completion: ([String], [Int]) -> Void)
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
    private var statisticsDateDays: [String]?
    private var statisticsTimeDays: [Int]?
    private var statisticsDays: [String: Int]?
    
    init(mainRouter: MainRouterProtocol?, dataStore: DataStoreProtocol?, index: Int, predicate: NSPredicate) {
        self.mainRouter = mainRouter
        self.dataStore = dataStore
        self.index = index
        self.predicate = predicate
        self.dataStore?.timerArray = realm.objects(TimerModelData.self).filter(predicate)
        model = dataStore?.timerArray
        reload()
        statisticsStart()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.tableView?.reloadData()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("timerDone"), object: nil)
        dataStore?.timerStatisticsNotNil(days: .week, index: index, predicate: predicate, completion: { timerDays, timerTime in
            statisticsDateDays = timerDays
            statisticsTimeDays = timerTime
        })
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
    
    func sentDaysStatistics(completion: ([String], [Int]) -> Void) {
        completion(statisticsDateDays ?? [], statisticsTimeDays ?? [])
        
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
        dataStore?.timerStatisticsNotNil(days: days, index: index, predicate: predicate, completion: { timerDays, timerTime in
            statisticsDateDays = timerDays
            statisticsTimeDays = timerTime
        })
        DispatchQueue.main.async { 
            tableView.reloadData()
        }
    }
}


extension Date {
    static func getFormattedDatetest(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date? = dateFormatterGet.date(from: "2018-02-01T19:10:04+00:00")
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }
}


extension Date {
   func getFormattedDatee(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
