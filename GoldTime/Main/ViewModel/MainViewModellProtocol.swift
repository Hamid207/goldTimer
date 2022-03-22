//
//  MainViewModellProtocol.swift
//  GoldTime
//
//  Created by Hamid Manafov on 04.03.22.
//

import Foundation
import RealmSwift

protocol MainViewModellProtocol {
    func tapTHeAddNewTimerVc()
    func tapOnTheTimerDetailVc(index: Int)
    func tapOnTheEditVc(timerModel: TimerModelData, index: Int)
    var index: Int? { get set }
    var timerCounting: Bool? { get set }
    var model: Results<TimerModelData>? { get set }
    var collectionView: UICollectionView? { get set }
    var weekDayCollectionView: UICollectionView? { get set }
    func timerStartStop(timerCounting: Bool, index: Int?, startTime: Date?, stopTime: Date?)
    func remiveTest()
    func timerTimeUpdate(timerTimeUpdate: Int, index: Int?)
    func pomodoroTimeUpdate(newTime: Int, pomdoroTimerBreakOrWork: Bool, index: Int)
    func timerRemove(modelIndex: TimerModelData, removeBool: Bool, index: Int, view: UIViewController, collectionView: UICollectionView)
    func pomdoroStartStopTime(index: Int?, pomdoroStartTime: Date?, pomdoroStopTime: Date?)
    func setIndex(index: Int?)
    var weekDayArrayEU: [String]? { get set }
    var weekDayArrayUSA: [String]? { get set }
    var calendarRegion: Bool { get set }
    var tapWeekDayArray: [Int : Bool]? { get set }
    func sentPredicate(predicate: NSPredicate)
    var predicateRepeat: NSPredicate? { get set }
    var dataStore: DataStoreProtocol? { get set }
    var toDay: Int? { get set }
    var checkDay: Int? { get set }
    var trueDay: Int? { get set }
    var editDayIndex: Int? { get set }
    var viewController: UIViewController? { get set }
    func scrollToIndex(index:Int)
    var timerDoneAlert: TimerDoneAlertProtocol? { get }
    init(mainRouter: MainRouterProtocol?, dataStore: DataStoreProtocol?, timerStatistics: TimerStatistics?, timerNotifications: TimerNotificationsProtocol?, timerDoneAlert: TimerDoneAlertProtocol?, timerAlert: TimerAlertProtocol?)
}
