//
//  MainViewController.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

final class MainViewController: UIViewController {
    
    //    var tableView = UITableView(frame: .zero, style: .plain)
    //        var headerBool = true
    //        let range: Range<CGFloat> = (-100..<0)
    //        var lastContentOffset: CGFloat = 0
    
    var viewModel: MainViewModelProtocol?
    var viewModell: MainViewModellProtocol?
        
    let weekDayView = UIView()
    
    private var startScrolViewRect = false
    
    let weekDayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isPagingEnabled = false
        return cv
    }()
    
    
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isPagingEnabled = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true //tabbar off
        //    navigationItem.title = "Main Time"
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackroundColor")
        navigationController?.navigationBar.backgroundColor = UIColor(named: "BackroundColor")
        //        UINavigationBar.appearance().barTintColor = .red
        //        UINavigationBar.appearance().tintColor = .white
        //        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        //        UINavigationBar.appearance().isTranslucent = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nav()
        mainViewSetup()
        viewModell?.viewController = self
        //    viewModel?.collectionView = mainCollectionView
        viewModell?.collectionView = mainCollectionView
        viewModell?.weekDayCollectionView = weekDayCollectionView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
        
        //        viewModel?.timerModel()
    }
    
    
    override func viewDidLayoutSubviews() {
        //app girenkimi ager hansisa timer start olubsa scrolu ora cevirir
        if startScrolViewRect == false {
            guard let index = viewModell?.dataStore?.lastIndex?.first else { return }
            if index.index != 0, index.index != 1 {
                if viewModell?.model?.count == index.index + 1{
                    viewModell?.scrollToIndex(index: index.index)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.startScrolViewRect = true
                    }
                }else {
                    viewModell?.scrollToIndex(index: index.index + 1)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.startScrolViewRect = true
                    }
                }
            }
            
        }
    }
}
