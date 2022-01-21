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
        addNewTimertableView.allowsSelection = false // tableViewnu basmaq olmur
        addNewTimertableView.backgroundColor = .white
//        tableView.tableHeaderView = UIView()
        addNewTimertableView.tableFooterView = UIView()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewTimerTableViewCellId", for: indexPath) as! AddNewTimerTableViewCell
        cell.update(color: viewModel?.color)
        cell.addTimerDelegate = self
        cell.addColorDelegate = self
        return cell
    }
}

extension AddNewTimerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.frame.height)
    }
}
