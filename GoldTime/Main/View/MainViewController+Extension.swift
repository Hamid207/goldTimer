//
//  MainViewController+Extension.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

extension MainViewController {
    
    func nav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.rectangle.portrait.fill")
                                                            , style: .done, target: self, action: #selector(addVC))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "OtherColor")
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .remove, style: .done, target: self, action: #selector(removeTest))
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
        weekDayView.backgroundColor = .clear
        //        weekDayView.layer.borderWidth = 1
        //        weekDayView.layer.borderColor = UIColor.black.cgColor
        weekDayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        weekDayView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        weekDayView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        weekDayView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/14).isActive = true
        
        weekDayView.addSubview(weekDayCollectionView)
        weekDayCollectionView.layer.borderWidth = 1
        weekDayCollectionView.layer.borderColor = UIColor.black.cgColor
        weekDayCollectionView.layer.cornerRadius = 10
        weekDayCollectionView.delegate = self
        weekDayCollectionView.dataSource = self
        weekDayCollectionView.backgroundColor = .white
        weekDayCollectionView.showsHorizontalScrollIndicator = false
        weekDayCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weekDayCollectionView.register(WeekDayCollectionViewCell.self, forCellWithReuseIdentifier: "weekDayCell")
        weekDayCollectionView.topAnchor.constraint(equalTo: weekDayView.topAnchor).isActive = true
        weekDayCollectionView.leadingAnchor.constraint(equalTo: weekDayView.leadingAnchor, constant: 10).isActive = true
        weekDayCollectionView.trailingAnchor.constraint(equalTo: weekDayView.trailingAnchor, constant: -10).isActive = true
        //        weekDayCollectionView.heightAnchor.constraint(equalTo: weekDayView.heightAnchor, multiplier: 1/5).isActive = true
        weekDayCollectionView.bottomAnchor.constraint(equalTo: weekDayView.bottomAnchor).isActive = true
        
        view.addSubview(mainCollectionView)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        //        mainCollectionView.cancelInteractiveMovement()
        mainCollectionView.backgroundColor = .clear
        //        mainCollectionView.showsHorizontalScrollIndicator = false
        mainCollectionView.showsVerticalScrollIndicator = false
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        //        mainCollectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        mainCollectionView.register(MainCollectionViewCelll.self, forCellWithReuseIdentifier: "cell")
        mainCollectionView.topAnchor.constraint(equalTo: weekDayView.bottomAnchor, constant: 0).isActive = true
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
        viewModell?.timerStartStop(timerCounting: timerCounting, index: index, startTime: startTime, stopTime: stopStime)
    }
    
    func setIndex(index: Int?) {
        viewModell?.index = index
    }
    
    func addModelIndex(index: Int) {
        viewModell?.setIndex(index: index)
    }
    
    func sentAlert() {
        print("ancaq birin sec extension 2")
    }
}

//MARK: - TimerRemoveDelegate, TapOnTheEdirVcDelegate
extension MainViewController: TimerRemoveDelegate, TapOnTheEditVcDelegate {
    func showEditVc(index: Int) {
        viewModell?.tapOnTheEditVc(timerModel: (viewModell?.model?[index])!, index: index)
    }
    
    func removeIndex(modelIndex: TimerModelData, deleteBool: Bool, cellIndex: Int) {
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
        //        viewModell?.pomodoroTimeUpdate(newTime: newTime, pomdoroTimerBreakOrWork: pomdoroTimerBreakOrWork, index: index)
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
            return viewModell?.weekDayArrayEU?.count ?? 0
        }else {
            return viewModell?.model?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == weekDayCollectionView {
            let weekDayCell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekDayCell", for: indexPath) as? WeekDayCollectionViewCell
            let item: String?
            if viewModell?.calendarRegion == true {
                item = viewModell?.weekDayArrayUSA?[indexPath.item]
            }else {
                item = viewModell?.weekDayArrayEU?[indexPath.item]
            }
            let weekDayindex = indexPath.item + 1 == viewModell?.toDay // bu if else di bool qaytarir
            let item2 = viewModell?.tapWeekDayArray?[indexPath.item + 1]
            weekDayCell?.update(name: item ?? "", isSelected: weekDayindex, isBlackSelected: item2 ?? false)
            return weekDayCell ?? UICollectionViewCell()
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MainCollectionViewCelll
            //        cell.pushhDelegate = self
            //            print("CELLL INDEX == \(indexPath.item)")
            cell?.timerStartStopDelegate = self
            cell?.removeTimerDelegate = self
            cell?.setIndexDeleagte = self
            cell?.setTimerUpdateTimeDeleagte = self
            cell?.setPomodoroTimerUpdateTimeDeleagte = self
            cell?.pomodoroTimerStartStopDelegate = self
            cell?.addModelIndexDelegate = self
            cell?.sentAlertActionDelegate = self
            cell?.showEditVcDelegate = self
            if let item = viewModell?.model?[indexPath.item], let checkDay = viewModell?.checkDay {
                cell?.update(model: item, timerCounting: true, index: indexPath.row, checkDay: checkDay)
                cell?.timerRemoveIndex = item
            }
            return cell ?? UICollectionViewCell()
        }
    }
}

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainCollectionView {
            let index = indexPath.row
            viewModell?.tapOnTheTimerDetailVc(index: index)
            viewModell?.timerDoneAlert?.alertIselectedFalse()
            //            mainCollectionView.reloadData()
        }else {
            if viewModell?.tapWeekDayArray?[indexPath.item + 1] == false {
                for i in 1...7 {
                    viewModell?.tapWeekDayArray?[i] = false
                }
                viewModell?.tapWeekDayArray?[indexPath.item + 1] = true
                viewModell?.checkDay = indexPath.item + 1
                if viewModell?.calendarRegion == true {
                    let usaDay = viewModell?.weekDayArrayUSA?[indexPath.item]
                    let predicateRepeat = NSPredicate(format: "\(usaDay ?? "") = true")
                    viewModell?.sentPredicate(predicate: predicateRepeat)
                }else {
                    let euDay = viewModell?.weekDayArrayEU?[indexPath.item]
                    let predicateRepeat = NSPredicate(format: "\(euDay ?? "") = true")
                    viewModell?.sentPredicate(predicate: predicateRepeat)
                }
                viewModell?.editDayIndex = indexPath.item + 1
                DispatchQueue.main.async {
                    self.weekDayCollectionView.reloadData()
                    self.mainCollectionView.reloadData()
                }
                
                if indexPath.item + 1 != viewModell?.toDay {
                    viewModell?.scrollToIndex(index: 0)
                }
            }
            
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainCollectionView {
            return CGSize(width: view.frame.width - 20, height: view.frame.height / 3.3)
        }else {
            return CGSize(width: weekDayView.frame.width / 7.7, height: weekDayView.frame.height - 10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == weekDayCollectionView {
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            
        }
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == weekDayCollectionView {
            return 1
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == weekDayCollectionView {
            return 1
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == mainCollectionView {
            cell.alpha = 0
            UIView.animate(withDuration: 0.5) {
                cell.alpha = 1
            }
        }
    }
    
    //user dark mode secende yada light mode qayidanda bu func ishdeyir
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // do whatever you want to do
        print("DARK MODE ")
        weekDayCollectionView.reloadData()
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
