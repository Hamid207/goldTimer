//
//  EditViewController+Extension.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

extension EditViewController {
    func nav() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward")
                                                            , style: .done, target: self, action: #selector(popVC))
        navigationItem.leftBarButtonItem?.tintColor = .lightGray
    }
    
    @objc func popVC() {
        viewModel?.popVC()
    }
    
    func setupItem() {
        editTimertableView.delegate = self
        editTimertableView.dataSource = self
        editTimertableView.register(EditTimerNameTableViewCell.self, forCellReuseIdentifier: "EditTimerNameTableViewCellId")
        editTimertableView.register(EditTimerPickerTableViewCell.self, forCellReuseIdentifier: "EditTimerPickerTableViewCellId")
        editTimertableView.register(EditWeekDayTableViewCell.self, forCellReuseIdentifier: "EditWeekDayTableViewCellId")
        editTimertableView.register(EditColorTableViewCell.self, forCellReuseIdentifier: "EditColorTableViewCellId")
        editTimertableView.register(EditSaveButtonTableViewCell.self, forCellReuseIdentifier: "EditSaveButtonTableViewCellId")
        editTimertableView.register(HeaderTableviewCell.self, forHeaderFooterViewReuseIdentifier: "header")
        editTimertableView.allowsSelection = false // tableViewnu basmaq olmur
        editTimertableView.backgroundColor = .clear
//        tableView.tableHeaderView = UIView()
//        editTimertableView.tableFooterView = UIView()
        editTimertableView.separatorStyle = .none
        view.addSubview(editTimertableView)
        editTimertableView.translatesAutoresizingMaskIntoConstraints = false
        editTimertableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        editTimertableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        editTimertableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        editTimertableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension EditViewController: SentTimerNameDelegate, SaveWeekDayDelegate, SentColorDelegate, SentTimerTimeDelegate, SaveButtonDelegate {
    func sentTimerName(name: String?) {
//        viewModel?.saveTimerName(name: name)
    }
    
    func sentTimerTime(h: Int, m: Int) {
//        viewModel?.saveTimerTime(hourse: h, minute: m)
    }
    
    func saveWeekDay(mon: Bool, tue: Bool, wed: Bool, thu: Bool, fri: Bool, sat: Bool, sun: Bool) {
//        viewModel?.saveTimerWeekDay(mon: mon, tue: tue, wed: wed, thu: thu, fri: fri, sat: sat, sun: sun)
    }
    
    func setColorDelegate(color: String?) {
//        viewModel?.saveTimerColor(color: color)
    }
    
    func saveTimer() {
//        viewModel?.saveTimerButton()
    }
}


extension EditViewController: UITableViewDataSource {
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "EditTimerNameTableViewCellId", for: indexPath) as! EditTimerNameTableViewCell
                cell.sentTimerNameDelegate = self
//                cell.update(color: viewModel?.color)
                return cell
            case 1:
                let timerPickerCell = tableView.dequeueReusableCell(withIdentifier: "EditTimerPickerTableViewCellId", for: indexPath) as! EditTimerPickerTableViewCell
                timerPickerCell.sentTimerTimeDelegate = self
                return timerPickerCell
            case 2:
                let addWeekCell = tableView.dequeueReusableCell(withIdentifier: "EditWeekDayTableViewCellId", for: indexPath) as! EditWeekDayTableViewCell
                addWeekCell.saveWeekDayDelegate = self
                return addWeekCell
            case 3:
                let addColorCell = tableView.dequeueReusableCell(withIdentifier: "EditColorTableViewCellId", for: indexPath) as! EditColorTableViewCell
                addColorCell.sentColorDelegate = self
                return addColorCell
            case 4:
                let saveButtonCell = tableView.dequeueReusableCell(withIdentifier: "EditSaveButtonTableViewCellId", for: indexPath) as! EditSaveButtonTableViewCell
                saveButtonCell.saveButtonDelegate = self
//                let item = viewModel?.saveButtonIsSelected
//                saveButtonCell.update(isSelected: item!, indexPathSection: indexPath)
                return saveButtonCell
            default:
                return UITableViewCell()
        }
    }
}

extension EditViewController: UITableViewDelegate {
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


