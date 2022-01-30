//
//  EditTimerNameTableViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 30.01.22.
//

import UIKit

class EditTimerNameTableViewCell: UITableViewCell {
        
    weak var sentTimerNameDelegate: SentTimerNameDelegate?
    
//    private lazy var pomodoroTime: Int? = 0
//    private lazy var isPomodoroTimerOnOff: Bool = false
//    private lazy var isTimer24HoursResetOnOff = false

        
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        textField.placeholder = "Timer name"
        textField.textAlignment = .center
        textField.contentVerticalAlignment = .center
        textField.textContentType = .name
        textField.returnKeyType = .done
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subView()
    }
    
//    func update(color: UIColor?) {
//
//    }
    
    private func subView() {
        self.backgroundColor = .clear
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = 10
    }
    
    @objc private func sentNameAction() {
        sentTimerNameDelegate?.sentTimerName(name: nameTextField.text)
    }
    
    private func setup() {
        contentView.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        nameTextField.addTarget(self, action: #selector(sentNameAction), for: .editingChanged)
    }
}
