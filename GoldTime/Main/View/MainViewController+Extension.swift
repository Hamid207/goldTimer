//
//  MainViewController+Extension.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

extension MainViewController {
    
    func nav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus")
                                                            , style: .done, target: self, action: #selector(addVC))
        //                navigationItem.rightBarButtonItem?.tintColor = .green
        //        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "headerColor")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .remove, style: .done, target: self, action: #selector(removeTest))
    }
    
    @objc func addVC() {
        viewModell?.tapTHeAddNewTimerVc()
    }
    
    @objc func removeTest() {
        DispatchQueue.main.async {
            self.viewModell?.remiveTest()
            self.mainCollectionView.reloadData()
            //            var a = IndexPath(item: 0, section: 0)
            //            self.mainCollectionView.deleteItems(at: [viewModel?.model?.last])
            //            self.mainCollectionView.reloadData()
            //            self.tableView.reloadData()
            
        }
    }
    
    func mainViewSetup() {
        view.addSubview(weekDayView)
        weekDayView.translatesAutoresizingMaskIntoConstraints = false
        weekDayView.backgroundColor = .white
//        weekDayView.layer.borderWidth = 1
//        weekDayView.layer.borderColor = UIColor.black.cgColor
        weekDayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        weekDayView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        weekDayView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        weekDayView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10).isActive = true
            
        weekDayView.addSubview(weekDayCollectionView)
//        weekDayCollectionView.layer.borderWidth = 1
//        weekDayCollectionView.layer.borderColor = UIColor.black.cgColor
//        weekDayCollectionView.layer.cornerRadius = 10
        weekDayCollectionView.delegate = self
        weekDayCollectionView.dataSource = self
        weekDayCollectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        weekDayCollectionView.showsHorizontalScrollIndicator = false
        weekDayCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weekDayCollectionView.register(WeekDayCollectionViewCell.self, forCellWithReuseIdentifier: "weekDayCell")
        weekDayCollectionView.topAnchor.constraint(equalTo: weekDayView.topAnchor).isActive = true
        weekDayCollectionView.leadingAnchor.constraint(equalTo: weekDayView.leadingAnchor, constant: 15).isActive = true
        weekDayCollectionView.trailingAnchor.constraint(equalTo: weekDayView.trailingAnchor, constant: -15).isActive = true
//        weekDayCollectionView.heightAnchor.constraint(equalTo: weekDayView.heightAnchor, multiplier: 1/5).isActive = true
        weekDayCollectionView.bottomAnchor.constraint(equalTo: weekDayView.bottomAnchor).isActive = true
        
        view.addSubview(mainCollectionView)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        //        mainCollectionView.cancelInteractiveMovement()
        mainCollectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        mainCollectionView.showsHorizontalScrollIndicator = false
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //        mainCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        mainCollectionView.register(MainCollectionViewCelll.self, forCellWithReuseIdentifier: "cell")
        mainCollectionView.topAnchor.constraint(equalTo: weekDayView.bottomAnchor, constant: 5).isActive = true
        mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //        mainCollectionView.indexPathsForVisibleItems
    }

}

//MARK: - PushTimerDetailVCDelegate
extension MainViewController: PushTimerDetailVCDelegate {
    func timerStartDelegate(index: Int?, startPauseBool: Bool, bugFixBool: Bool?, secondTimerDontStart: Bool?) {
        viewModel?.bugFixBool = bugFixBool
        viewModel?.timerStart(index: index, secondTimerDontStart: secondTimerDontStart, bugFixBool: bugFixBool)
        //        print("startPauseBool = \(startPauseBool)  " + "  INDEX = \(index)  " + " secondTimerDontStart = \(secondTimerDontStart)  " + " bugFixBool = \(bugFixBool)")
    }
}

//MARK: - TimerStartStopDelegate, SetIndexDelegate, AddModelIndexDelegate, SentAlertActionDelegate
extension MainViewController: TimerStartStopDelegate, SetIndexDelegate, AddModelIndexDelegate, SentAlertActionDelegate {
    func timerStartStop(index: Int?, timerCounting: Bool, startTime: Date?, stopStime: Date?) {
//        print("INDEX == \(index)   timercouting == \(timerCounting)")
        viewModell?.timerStartStop(timerCounting: timerCounting, index: index, startTime: startTime, stopTime: stopStime)
    }
    
    func setIndex(index: Int?) {
        viewModell?.index = index
    }
    
    func addModelIndex(index: Int) {
        viewModell?.setIndex(index: index)
    }
    
    func sentAlert() {
        print("REIS ALINMADI ancaq birin sec extension 2")
    }
}

//MARK: - TimerRemoveDelegate
extension MainViewController: TimerRemoveDelegate {
    func removeIndex(modelIndex: TimerModelData, deleteBool: Bool, cellIndex: Int) {
        //        viewModel?.timerRemove(modelIndex: modelIndex, deleteBool: deleteBool, cellIndex: cellIndex, view: self, collectionView: mainCollectionView)
        viewModell?.timerRemove(modelIndex: modelIndex, removeBool: deleteBool, index: cellIndex, view: self, collectionView: mainCollectionView)
    }
}

//MARK: - SetTimerUpdateTimeDelegate, SetPomdoroTimerUpdateTimeDelegate
extension MainViewController: SetTimerUpdateTimeDelegate, SetPomdoroTimerUpdateTimeDelegate {
    func setTimerNewTime(newTime: Int, index: Int) {
        if viewModell?.toDay == viewModell?.checkDay {
            viewModell?.timerTimeUpdate(timerTimeUpdate: newTime, index: index)
        }
    }
    
    func setPomodoroNewTime(newTime: Int, pomdoroTimerBreakOrWork: Bool, index: Int) {
        viewModell?.pomodoroTimeUpdate(newTime: newTime, pomdoroTimerBreakOrWork: pomdoroTimerBreakOrWork, index: index)
    }
}

//MARK: - PomodoroTimerStartStopDelegate
extension MainViewController: PomodoroTimerStartStopDelegate {
    func pomodoroTimerStartStop(index: Int?, pomodoroStartTime: Date?, pomdoroStopTime: Date?) {
        viewModell?.pomdoroStartStopTime(index: index, pomdoroStartTime: pomodoroStartTime, pomdoroStopTime: pomdoroStopTime)
    }
}


//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == weekDayCollectionView {
            return viewModell?.weekDayArray?.count ?? 0
        }else {
            return viewModell?.model?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == weekDayCollectionView {
            let weekDayCell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekDayCell", for: indexPath) as? WeekDayCollectionViewCell
            let item = viewModell?.weekDayArray?[indexPath.item]
            let item2 = viewModell?.tapWeekDayArray?[indexPath.item + 1]
//            print("AAAAA \(indexPath.row + 1) == \(item2)")
            let datee = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            let weekday = Calendar.current.component(.weekday, from: datee)
            let index = indexPath.row + 1 == weekday // bu if else di
            weekDayCell?.update(name: item!, isSelected: index, isBlackSelected: item2 ?? false)
            return weekDayCell!
        }
        
        if collectionView == mainCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MainCollectionViewCelll
            //        cell.pushhDelegate = self
            cell?.timerStartStopDelegate = self
            cell?.removeTimerDelegate = self
            cell?.setIndexDeleagte = self
            cell?.setTimerUpdateTimeDeleagte = self
            cell?.setPomodoroTimerUpdateTimeDeleagte = self
            cell?.pomodoroTimerStartStopDelegate = self
            cell?.addModelIndexDelegate = self
            cell?.sentAlertActionDelegate = self
            if let item = viewModell?.dataStore?.timerArray?[indexPath.item] {
                cell?.update(model: item, timerCounting: true, index: indexPath.row, checkDay: (viewModell?.checkDay)!)
                cell?.timerRemoveIndex = item
            }
            return cell!
        }
        
        return UICollectionViewCell()
    }
}

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainCollectionView {
            let index = indexPath.row
            viewModell?.tapOnTheTimerDetailVc(index: index)
//            mainCollectionView.reloadData()
        }else {
            for i in 1...7 {
                viewModell?.tapWeekDayArray?[i] = false
            }
            viewModell?.tapWeekDayArray?[indexPath.item + 1] = true
            viewModell?.checkDay = indexPath.item + 1
            let day = viewModell?.weekDayArray?[indexPath.item]
            let predicateRepeat = NSPredicate(format: "\(day!) = true")
            viewModell?.sentPredicate(predicate: predicateRepeat)
            DispatchQueue.main.async {
                self.weekDayCollectionView.reloadData()
                self.mainCollectionView.reloadData()
            }
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainCollectionView {
            return CGSize(width: view.frame.width - 40, height: view.frame.height / 3)
        }else {
            return CGSize(width: view.frame.width / 8, height: weekDayView.frame.height - 10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == weekDayCollectionView {
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == weekDayCollectionView {
            return 1
        }
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == weekDayCollectionView {
            return 1
        }
        return 20
    }
}

////MARK: - UITableViewDataSource
//extension MainViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel?.model?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell {
//
//            let item = viewModel?.model?[indexPath.row]
//            cell.update(model: item!)
//            cell.index = indexPath.row
//            cell.pushhDelegate = self
//            cell.accessoryType = .disclosureIndicator
//            return cell
//        }
//        return UITableViewCell()
//    }
//}
//
//extension MainViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
//}

//extension MainViewController: UIScrollViewDelegate {
//
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//       lastContentOffset = scrollView.contentOffset.y
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
////        print(scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height)
//        let delta = scrollView.contentOffset.y - lastContentOffset
//        if delta > 0 {
////            topConstraint.constant = min (topConstraint.constant - delta, range.upperBound)
//            UIView.animate(withDuration: 0.25, animations: { [weak self] in
//                if self?.headerBool == true{
//                    self?.weekDayView.center.y -= 100
//                    self?.mainCollectionView.center.y -= 100
////                      self?.collectionView.center.y -= 100
////                      self?.headerView.alpha = 0.0
////                      self?.mainCollectionView.alpha = 0.0
////                    self?.headerView.transform = CGAffineTransform(scaleX: 2.3, y: 1.3)
//                }
//                self?.headerBool = false
//            }, completion: nil)
//
//        } else {
//            UIView.animate(withDuration: 0.25, animations: { [weak self] in
//                if self?.headerBool == false{
//                    self?.weekDayView.center.y += 100
//                    self?.mainCollectionView.center.y += 100
////                      self?.collectionView.center.y += 100
////                      self?.headerView.alpha = 1.0
////                      self?.collectionView.alpha = 1.0
////                    self?.headerView.transform = CGAffineTransform(scaleX: 1.3, y: 1.0)
//                }
//                self?.headerBool = true
//            }, completion: nil)
//        }
//        lastContentOffset = scrollView.contentOffset.y
//    }
//
//
//    func scrollViewDidBeginDragging(_ scrollView: UIScrollView) {
//      // Where lastContentOffset is a class variable of type CGFloat
//      lastContentOffset = scrollView.contentOffset.y
//
//    }
//

//}
