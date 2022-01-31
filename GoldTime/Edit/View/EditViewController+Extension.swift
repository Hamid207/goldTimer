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

extension EditViewController: EditTimerNameDelegate, EditWeekDayDelegate, EditColorDelegate, EditTimerTimeDelegate, EditSaveButtonDelegate {
    func sentNewTimerName(name: String?) {
        viewModel?.saveTimerName(name: name)
    }
    
    func sentNewTime(h: Int, m: Int) {
        viewModel?.saveTimerTime(hourse: h, minute: m)
    }
    
    func sentNewDay(mon: Bool, tue: Bool, wed: Bool, thu: Bool, fri: Bool, sat: Bool, sun: Bool) {
        viewModel?.saveTimerWeekDay(mon: mon, tue: tue, wed: wed, thu: thu, fri: fri, sat: sat, sun: sun)
    }
    
    func sentNewColor(color: String?, colorIndex: Int) {
        viewModel?.saveTimerColor(color: color, colorIndex: colorIndex)
    }
    
    func saveTimer() {
        viewModel?.saveTimerButton()
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
                cell.sentNewTimerNameDelegate = self
                let timerName = viewModel?.model?.name
                cell.update(timerName: timerName ?? "")
                return cell
            case 1:
                let editTimerPickerCell = tableView.dequeueReusableCell(withIdentifier: "EditTimerPickerTableViewCellId", for: indexPath) as! EditTimerPickerTableViewCell
                editTimerPickerCell.sentNewTimerDelegate = self
                let timerTime = viewModel?.model!.timerTime
                editTimerPickerCell.update(timerTime: timerTime!)
                return editTimerPickerCell
            case 2:
                let editWeekCell = tableView.dequeueReusableCell(withIdentifier: "EditWeekDayTableViewCellId", for: indexPath) as! EditWeekDayTableViewCell
                editWeekCell.editWeekDayDelegate = self
                let mon = viewModel?.model?.Mon
                let tue = viewModel?.model?.Tue
                let wed = viewModel?.model?.Wed
                let thu = viewModel?.model?.Thu
                let fri = viewModel?.model?.Fri
                let sat = viewModel?.model?.Sat
                let sun = viewModel?.model?.Sun
                editWeekCell.update(mon: mon ?? false, tue: tue ?? false, wed: wed ?? false, thu: thu ?? false, fri: fri ?? false, sat: sat ?? false, sun: sun ?? false)
                return editWeekCell
            case 3:
                let editColorCell = tableView.dequeueReusableCell(withIdentifier: "EditColorTableViewCellId", for: indexPath) as! EditColorTableViewCell
                editColorCell.editColorDelegate = self
                let colorIndex = viewModel?.model?.timerColorIndex
                editColorCell.update(colorIndex: colorIndex)
                return editColorCell
            case 4:
                let saveButtonCell = tableView.dequeueReusableCell(withIdentifier: "EditSaveButtonTableViewCellId", for: indexPath) as! EditSaveButtonTableViewCell
                saveButtonCell.editSaveButtonDelegate = self
                let item = viewModel?.saveButtonIsSelected
                saveButtonCell.update(isSelected: item!)
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


