//
//  AddNewTimerViewController+Extension.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

extension AddNewTimerViewController {
    func nav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")
                                                            , style: .done, target: self, action: #selector(popVC))
        navigationItem.leftBarButtonItem?.tintColor = .lightGray
    }
    
    @objc private func popVC() {
        viewModel?.popVC()
    }
    
    func setupItem() {
        addNewTimertableView.delegate = self
        addNewTimertableView.dataSource = self
        addNewTimertableView.register(AddNewTimerTableViewCell.self, forCellReuseIdentifier: "AddNewTimerTableViewCellId")
        addNewTimertableView.register(TimerPickerTableViewCell.self, forCellReuseIdentifier: "TimerPickerTableViewCellId")
        addNewTimertableView.register(AddWeekDayTableViewCell.self, forCellReuseIdentifier: "AddWeekDayTableViewCellId")
        addNewTimertableView.register(AddColorTableViewCell.self, forCellReuseIdentifier: "AddColorTableViewCellId")
        addNewTimertableView.register(SaveButtonTableViewCell.self, forCellReuseIdentifier: "SaveButtonTableViewCellId")
        addNewTimertableView.register(HeaderTableviewCell.self, forHeaderFooterViewReuseIdentifier: "header")
        addNewTimertableView.allowsSelection = false // tableViewnu basmaq olmur
        addNewTimertableView.backgroundColor = .clear
//        tableView.tableHeaderView = UIView()
//        addNewTimertableView.tableFooterView = UIView()
        addNewTimertableView.separatorStyle = .none
        view.addSubview(addNewTimertableView)
        addNewTimertableView.translatesAutoresizingMaskIntoConstraints = false
        addNewTimertableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        addNewTimertableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        addNewTimertableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        addNewTimertableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension AddNewTimerViewController: SentTimerNameDelegate, SaveWeekDayDelegate, SentColorDelegate, SentTimerTimeDelegate, SaveButtonDelegate {
    func sentTimerName(name: String?) {
        viewModel?.saveTimerName(name: name)
    }
    
    func sentTimerTime(h: Int, m: Int) {
        viewModel?.saveTimerTime(hourse: h, minute: m)
    }
    
    func saveWeekDay(mon: Bool, tue: Bool, wed: Bool, thu: Bool, fri: Bool, sat: Bool, sun: Bool) {
        viewModel?.saveTimerWeekDay(mon: mon, tue: tue, wed: wed, thu: thu, fri: fri, sat: sat, sun: sun)
    }
    
    func setColorDelegate(color: String?) {
        viewModel?.saveTimerColor(color: color)
    }
    
    func saveTimer() {
        viewModel?.saveTimerButton()
    }
}

extension AddNewTimerViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return 1
            case 1: return 1
            case 2: return 1
            case 3: return 1
            default:
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewTimerTableViewCellId", for: indexPath) as! AddNewTimerTableViewCell
                cell.sentTimerNameDelegate = self
//                cell.update(color: viewModel?.color)
                return cell
            case 1:
                let timerPickerCell = tableView.dequeueReusableCell(withIdentifier: "TimerPickerTableViewCellId", for: indexPath) as! TimerPickerTableViewCell
                timerPickerCell.sentTimerTimeDelegate = self
                return timerPickerCell
            case 2:
                let addWeekCell = tableView.dequeueReusableCell(withIdentifier: "AddWeekDayTableViewCellId", for: indexPath) as! AddWeekDayTableViewCell
                addWeekCell.saveWeekDayDelegate = self
                return addWeekCell
            case 3:
                let addColorCell = tableView.dequeueReusableCell(withIdentifier: "AddColorTableViewCellId", for: indexPath) as! AddColorTableViewCell
                addColorCell.sentColorDelegate = self
                return addColorCell
            case 4:
                let saveButtonCell = tableView.dequeueReusableCell(withIdentifier: "SaveButtonTableViewCellId", for: indexPath) as! SaveButtonTableViewCell
                saveButtonCell.saveButtonDelegate = self
                let item = viewModel?.saveButtonIsSelected
                saveButtonCell.update(isSelected: item!)
                return saveButtonCell
            default:
                return UITableViewCell()
        }
    }
}

extension AddNewTimerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0: return 44
            case 1: return CGFloat(view.frame.height / 4)
            case 2: return CGFloat(view.frame.height / 7)
            case 3: return CGFloat(view.frame.height / 13)
            default:
                return  CGFloat(view.frame.height / 8)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! HeaderTableviewCell
        header.headerConfigure(section: section)
        return header
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
            case 0: return 25
            case 1: return 25
            case 2: return 40
            case 3: return 35
            default:
                return 40
        }    }
}


