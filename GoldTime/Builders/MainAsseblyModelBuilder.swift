//
//  MainAsseblyModelBuilder.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

protocol MainAsseblyModelBuilderProtocol {
  func creatMainModule(mainRouter: MainRouterProtocol) -> UIViewController
  func creatAddNewTimerModule(mainRouter: MainRouterProtocol) -> UIViewController
  func creatTimerDetailModule(mainRouter: MainRouterProtocol, index: Int, predicate: NSPredicate) -> UIViewController
  func creatEditModule(mainRouter: MainRouterProtocol, timerModel: TimerModelData, index: Int, predicate: NSPredicate, day: Int, col: UICollectionView) -> UIViewController
}

class MainAsseblyModelBuilder: MainAsseblyModelBuilderProtocol {
  //MARK: - MainViewController
  func creatMainModule(mainRouter: MainRouterProtocol) -> UIViewController {
    let view = MainViewController()
    let timerTimeArray = TimerTimerArray()
    let dataStore = DataStore()
    let timerStatistics = TimerStatistics()
    let timerNotifications = TimerNotifications()
    let timerDoneAlert = TimerDoneAlert()
    let timerAlert = TimerAlert()
    let viewModel = MainViewModell(mainRouter: mainRouter, timerTimerArray: timerTimeArray, dataStore: dataStore, timerStatistics: timerStatistics, timerNotifications: timerNotifications, timerDoneAlert: timerDoneAlert, timerAlert: timerAlert)
    view.viewModell = viewModel
    return view
  }
  
  //MARK: - AddNewTimerViewController
  func creatAddNewTimerModule(mainRouter: MainRouterProtocol) -> UIViewController {
    let view = AddNewTimerViewController()
    let timerTimeArray = TimerTimerArray()
    let dataStore = DataStore()
    let viewModel = AddNewTimerViewModel(mainRouter: mainRouter, timerTimerArray: timerTimeArray, dataStore: dataStore)
    view.viewModel = viewModel
    return view
  }
  
  //MARK: - TimerDetailViewController
  func creatTimerDetailModule(mainRouter: MainRouterProtocol, index: Int, predicate: NSPredicate) -> UIViewController {
    let view = TimerDetailViewController()
    let dataStore = DataStore()
    let timerStatistics = TimerStatistics()
    let viewModel = TimerDetailViewModel(mainRouter: mainRouter, dataStore: dataStore, index: index, predicate: predicate, timerStatistics: timerStatistics)
    view.viewModel = viewModel
    return view
  }
  
  //MARK: - EditViewController
  func creatEditModule(mainRouter: MainRouterProtocol, timerModel: TimerModelData, index: Int, predicate: NSPredicate, day: Int, col: UICollectionView) -> UIViewController {
    let view = EditViewController()
    let dataStore = DataStore()
    let viewModel = EditViewModel(mainRouter: mainRouter, dataStore: dataStore, timerModel: timerModel, index: index, predicate: predicate, day: day, col: col)
    view.viewModel = viewModel
    return view
  }
}
