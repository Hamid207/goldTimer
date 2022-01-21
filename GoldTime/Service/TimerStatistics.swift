//
//  TimerStatistics.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import Foundation
import RealmSwift

protocol  TimerStatisticsProtocol {
    var timerArray: Results<TimerModelData>? { get set }
    func saveTimerStatistics(key: String, value: Int, index: Int?)
    func addStatistic(days: TimerStatisticsEnum, index: Int?, predicate: NSPredicate) -> Int
}

class TimerStatistics: TimerStatisticsProtocol {
    var timerArray: Results<TimerModelData>?
    let calendar = Calendar.current
    var days = [String]()
    private var predecate: NSPredicate!
    init() {
        //gelecekde bunu dataStoreye kecmeldidi yeqinki cunki diyesen bele olanda 2 dene massiv olur ayri ayri timerstatistics birde dataStore ==================================
        timerArray = realm.objects(TimerModelData.self)
    }

    //MARK: - SaveTimerStatistics
    func saveTimerStatistics(key: String, value: Int, index: Int?) {
        try! realm.write{
            timerArray?[index!].timerStatistics[key] = value
        }
//        print("keyyy == \(key) value == \(value)")
    }
    
    //MARK: - AdStatistic
    func addStatistic(days: TimerStatisticsEnum, index: Int?, predicate: NSPredicate) -> Int {
        var time = 0
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
            
            timerArray = realm.objects(TimerModelData.self).filter(predicate)
            for days in dateArray {
                time += (timerArray?[index].timerStatistics[days]) ?? 0
            }
        }
        return time
    }
}
