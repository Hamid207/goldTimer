//
//  DataStore.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import RealmSwift

let realm = try! Realm()

protocol DataStoreProtocol {
    var timerArray: Results<TimerModelData>? { get set }
    var lastIndex: Results<LastIndex>? { get set }
//    var firstRunApp: Results<FirstRunApp>? { get set } 
    func saveObject(_ timerModel: TimerModelData)
    func saveLastIndex(_ lastIndexModel: LastIndex)
    func deleteLastIndex()
    func deleteObject(_ timerModel: TimerModelData)
    func userStaticSaveObject(_ userStaticModel: UserStatisticsData)
    func predicateFilter(predicate: NSPredicate?)
    func saveTimerStatistics(key: String, value: Int, index: Int?)

    func findOutStatistics(days: TimerStatisticsEnum, index: Int?, predicate: NSPredicate) -> (Int, [Int])
    func timerStatisticsNotNil(days: TimerStatisticsEnum, index: Int?, predicate: NSPredicate, completion: ([String], [Int]) -> Void)
}

final class DataStore: DataStoreProtocol {
    var timerArray: Results<TimerModelData>?
    var lastIndex: Results<LastIndex>?
//    var firstRunApp: Results<FirstRunApp>?
    private var predecate: NSPredicate!
    
    init() {
        timerArray = realm.objects(TimerModelData.self)
        lastIndex = realm.objects(LastIndex.self)
//        firstRunApp = realm.objects(FirstRunApp.self)
    }
    
    func predicateFilter(predicate: NSPredicate?) {
        predecate = predicate
        if predicate != nil {
            timerArray = realm.objects(TimerModelData.self).filter(predicate!)
        }else {
            //            timerArray = realm.objects(TimerModelData.self)
        }
    }
    
    //MARK: - SaveTimerStatistics
    func saveTimerStatistics(key: String, value: Int, index: Int?) {
        try! realm.write{
            guard let index = index else { return }
            timerArray?[index].timerStatistics[key] = value
        }
    }
    
 
    //MARK: - TimerStatisticsNotNil != 0
    func timerStatisticsNotNil(days: TimerStatisticsEnum, index: Int?, predicate: NSPredicate, completion: ([String], [Int]) -> Void) {
        var timeArray = [Int]()
        var timerTime = [Int]()
        var arrayDays = [String]()
        if let index = index {
            var dateArray = [String]()
            var startDate = Calendar.current.date(byAdding: .day, value: days.rawValue, to: Date())! // first date
            let endDate = Date() // last date
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            while startDate <= endDate {
                dateArray.append(formatter.string(from: startDate))
                startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
            }
            
            for days in dateArray {
                timeArray.append((timerArray?[index].timerStatistics[days]) ?? 0)
                timerTime = timeArray.filter{$0 != 0}
                if timerArray?[index].timerStatistics[days] != nil {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    dateFormatter.timeZone = TimeZone(identifier: "UTC")
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    let date = dateFormatter.date(from: days)
                    arrayDays.append(date?.getFormattedDatee(format: "MMM d") ?? "")
                }
            }
//            print(arrayDays, timerTime)
            completion(arrayDays.reversed(), timerTime.reversed())
        }
    }
    
    //MARK: - Ad Statistic
    func findOutStatistics(days: TimerStatisticsEnum, index: Int?, predicate: NSPredicate) -> (Int, [Int]) {
        //        timerArray = realm.objects(TimerModelData.self).filter(predicate)
        var time = 0
        var timeArray = [Int]()
        if let index = index {
            var dateArray = [String]()
            var startDate = Calendar.current.date(byAdding: .day, value: days.rawValue, to: Date())! // first date
            let endDate = Date() // last date
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            while startDate <= endDate {
                dateArray.append(formatter.string(from: startDate))
                //            print(formatter.string(from: startDate))
                startDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
            }
            
            for days in dateArray {
                timeArray.append((timerArray?[index].timerStatistics[days]) ?? 0)
                time += (timerArray?[index].timerStatistics[days]) ?? 0
            }
        }
        
        return (time, timeArray)
    }
    
    //save object DB
    func saveObject(_ timerModel: TimerModelData) {
        try! realm.write {
            realm.add(timerModel)
        }
    }
    
    func userStaticSaveObject(_ userStaticModel: UserStatisticsData) {
        try! realm.write{
            realm.add(userStaticModel)
        }
    }
    
    //delete Object DB
    func deleteObject(_ timerModel: TimerModelData) {
        try! realm.write {
            realm.delete(timerModel)
        }
    }
    
    //Save last timer use index
    func saveLastIndex(_ lastIndexModel: LastIndex) {
        try! realm.write {
            realm.add(lastIndexModel)
        }
    }
    
    //Delete last index
    func deleteLastIndex() {
        try! realm.write {
            realm.delete(lastIndex!)
        }
    }
    
//    //FirstRunAPp
//    func saveObject(_ firstRun: FirstRunApp) {
//        try! realm.write {
//            realm.add(firstRun)
//        }
//    }
    
}



