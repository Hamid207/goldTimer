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


extension AddNewTimerViewController: TimerItemAddDelegate {
    func timerAdd(timer: TimerModelData) {
        viewModel?.saveTimer(timer: timer)
        viewModel?.popVC()
    }
}


extension AddNewTimerViewController: SentColorDelegate, SentTimerTimeDelegate {
    func sentTimerTime(h: Int, m: Int) {
        print(h)
    }
    
    func setColorDelegate(color: UIColor) {
        print(color)
    }
}

extension AddNewTimerViewController: AddColorDelegate, UIColorPickerViewControllerDelegate{
    @available(iOS 14.0, *)
    func addColor() {
        let colorPickerVc =  UIColorPickerViewController()
        colorPickerVc.delegate = self
        present(colorPickerVc, animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
//        var color = viewController.selectedColor
//        print("color=== \(color.cgColor.components)")
        colorr = CGColor(srgbRed: 0.9522833228111267, green: 0.6849521994590759, blue: 0.23968574404716492, alpha: 1.0)
//        viewModel?.color = color
        addNewTimertableView.backgroundColor = UIColor(cgColor: colorr!)
        addNewTimertableView.reloadData()
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorr = CGColor(srgbRed: 0.9522833228111267, green: 0.6849521994590759, blue: 0.23968574404716492, alpha: 1.0)
//        viewModel?.color = color
        addNewTimertableView.backgroundColor = UIColor(cgColor: colorr!)
        viewModel?.color = color
        addNewTimertableView.reloadData()
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
                cell.update(color: viewModel?.color)
                cell.addTimerDelegate = self
                cell.addColorDelegate = self
                return cell
            case 1:
                let timerPickerCell = tableView.dequeueReusableCell(withIdentifier: "TimerPickerTableViewCellId", for: indexPath) as! TimerPickerTableViewCell
                timerPickerCell.sentTimerTimeDelegate = self
                return timerPickerCell
            case 2:
                let addWeekCell = tableView.dequeueReusableCell(withIdentifier: "AddWeekDayTableViewCellId", for: indexPath) as! AddWeekDayTableViewCell
                return addWeekCell
            case 3:
                let addColorCell = tableView.dequeueReusableCell(withIdentifier: "AddColorTableViewCellId", for: indexPath) as! AddColorTableViewCell
                addColorCell.sentColorDelegate = self
                return addColorCell
            case 4:
                let saveButtonCell = tableView.dequeueReusableCell(withIdentifier: "SaveButtonTableViewCellId", for: indexPath) as! SaveButtonTableViewCell
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


