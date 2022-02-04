//
//  AddNewTimerViewController.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

final class AddNewTimerViewController: UIViewController {
    
    var viewModel: AddNewTimerViewModelProtocol?
    
    var colorr: CGColor?
    lazy var addNewTimertableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "New Timer"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackroundColor")
        navigationController?.navigationBar.backgroundColor = UIColor(named: "BackroundColor")
        self.view.backgroundColor = UIColor(cgColor: colorr ?? .init(srgbRed: 250, green: 250, blue: 205, alpha: 1.0))
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        viewModel?.tableView = addNewTimertableView
        nav()
        setupItem()
    }

}
