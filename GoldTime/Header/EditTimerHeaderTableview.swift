//
//  EditTimerHeaderTableview.swift
//  GoldTime
//
//  Created by Hamid Manafov on 22.03.22.
//

import UIKit

class EditTimerHeaderTableview: UITableViewHeaderFooterView {

    var headerNameArray = ["", "", "Add day", "Color", ""]
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
//        label.text = "Header"
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.contentView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
    }
    
    func headerConfigure(section: Int) {
        headerLabel.text = headerNameArray[section]
    }
    
    private func setConstraints() {
        addSubview(headerLabel)
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3).isActive = true
    }

}
