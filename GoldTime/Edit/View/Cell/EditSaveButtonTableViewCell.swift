//
//  EditSaveButtonTableViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 30.01.22.
//

import UIKit

class EditSaveButtonTableViewCell: UITableViewCell {
    
    weak var saveButtonDelegate: SaveButtonDelegate?
    
    private let saveButtonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        itemSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.backgroundColor = .clear
        saveButton.layer.cornerRadius = 10
    }
    
    func update(isSelected: Bool, indexPathSection: IndexPath) {
        if isSelected == false {
            saveButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
//            saveButton.isHidden = true
        }else {
            saveButton.backgroundColor = .black
//            saveButton.isHidden = false
        }
    }
    
    @objc private func saveButtonTarget() {
        saveButtonDelegate?.saveTimer()
    }
    
    private func itemSetup() {
        addSubview(saveButtonView)
        saveButtonView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        saveButtonView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        saveButtonView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        saveButtonView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        //saveButton
        contentView.addSubview(saveButton)
        saveButton.centerYAnchor.constraint(equalTo: saveButtonView.centerYAnchor).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: saveButtonView.leadingAnchor, constant: 15).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: saveButtonView.trailingAnchor, constant: -15).isActive = true
        saveButton.heightAnchor.constraint(equalTo: saveButtonView.heightAnchor, multiplier: 1/2).isActive = true
        saveButton.addTarget(self, action: #selector(saveButtonTarget), for: .touchDown)
    }
}
