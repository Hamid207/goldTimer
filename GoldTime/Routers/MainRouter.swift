//
//  MainRouter.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

protocol MainRouterNC {
    var mainNaviGationController: UINavigationController? { get set }
    var mainAssemblyBuilder: MainAsseblyModelBuilderProtocol? { get set }
}

protocol MainRouterProtocol: MainRouterNC{
    func initialViewController()
    func showAddNewTimerVc()
    func showTimerDetail(index: Int, predicate: NSPredicate)
    func showEditViewController(timerModel: TimerModelData, index: Int, predicate: NSPredicate, day: Int, col: UICollectionView)
    func popVC()
}

final class MainRouter: MainRouterProtocol {
    var mainNaviGationController: UINavigationController?
    var mainAssemblyBuilder: MainAsseblyModelBuilderProtocol?
    
    init(mainNaviGationController: UINavigationController, mainAssemblyBuilder: MainAsseblyModelBuilderProtocol) {
        self.mainNaviGationController = mainNaviGationController
        self.mainAssemblyBuilder = mainAssemblyBuilder
    }
    
    //MARK: - MainViewController
    func initialViewController() {
        if let navigationController = mainNaviGationController {
            guard let mainVc = mainAssemblyBuilder?.creatMainModule(mainRouter: self) else { return }
            navigationController.viewControllers = [mainVc]
        }
    }
    
    //MARK: - AddNewTimerViewController
    func showAddNewTimerVc() {
        if let navigationController = mainNaviGationController {
            guard let addNewTimerVc = mainAssemblyBuilder?.creatAddNewTimerModule(mainRouter: self) else { return }
            navigationController.pushViewController(addNewTimerVc, animated: true)
        }
    }
    
    //MARK: - TimerDetailViewController
    func showTimerDetail(index: Int, predicate: NSPredicate) {
        if let navigationController = mainNaviGationController {
            guard let timerDetailVc = mainAssemblyBuilder?.creatTimerDetailModule(mainRouter: self, index: index, predicate: predicate) else { return }
            navigationController.pushViewController(timerDetailVc, animated: true)
        }
    }
    
    func showEditViewController(timerModel: TimerModelData, index: Int, predicate: NSPredicate, day: Int, col: UICollectionView) {
        if let navigationController = mainNaviGationController  {
            guard let editVc = mainAssemblyBuilder?.creatEditModule(mainRouter: self, timerModel: timerModel, index: index, predicate: predicate, day: day, col: col) else { return }
            navigationController.pushViewController(editVc, animated: true)
        }
    }
    
    func popVC() {
        if let navigationController = mainNaviGationController {
            navigationController.popViewController(animated: true)
        }
    }
}
