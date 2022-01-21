//
//  TabbarController.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

class TabbarController {
    private let tabBarController = UITabBarController()
    private let mainNavigationController = UINavigationController()
    private let mainAssemblyBuilder = MainAsseblyModelBuilder()
    private var mainRouter: MainRouterProtocol?
    
    //MARK: - MainViewController
    private func mainVc() {
        mainRouter = MainRouter(mainNaviGationController: mainNavigationController, mainAssemblyBuilder: mainAssemblyBuilder)
        mainNavigationController.tabBarItem = UITabBarItem(title: "Timer", image: nil, tag: 0)
        mainRouter?.initialViewController()
    }
    
    //MARK: - TabbarSettings
    private func tabbarSettings() {
        UITabBar.appearance().tintColor = UIColor(named: "headerColor")
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.setViewControllers([mainNavigationController], animated: false)
    }
    
    //MARK: - Tabbar
    public func tabBar() -> UITabBarController {
        tabbarSettings()
        mainVc()
        return tabBarController
    }
}
