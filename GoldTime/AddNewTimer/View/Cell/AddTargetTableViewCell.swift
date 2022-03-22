//
//  AddTargetTableViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 11.03.22.
//

import UIKit

final class AddTargetTableViewCell: UITableViewCell {
    
    weak var sendeValueDelegate: AddTagetValuesender?
    
    private let addTargetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let addTargetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.text = "0m"
        return label
    }()
    
    private let addTargetStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.minimumValue = 0
        stepper.maximumValue = 100
        stepper.autorepeat = true
        stepper.wraps = true
        return stepper
    }()
    
    private let targetTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        addTargetView.layer.cornerRadius = 5
    }
    
    @objc private func addTargetValue(_ sender: UIStepper) {
        addTargetLabel.text = "\(Int(sender.value))"
        sendeValueDelegate?.addTargetsenderValueDelegate(Int(sender.value))
    }
    
    func update(time: [Int], stepperValue: Int) {
        addTargetLabel.text = "\(stepperValue)"
        addTargetStepper.value = Double(stepperValue)
        if !time.isEmpty {
            let t = time[0] * 3600 + time[1] * 60
//            print(timeString(time: TimeInterval(stepperValue * t)))
            if time[0] == 0 && time[1] == 0{
                targetTime.text = ""
            }else {
                targetTime.text = timeString(time: TimeInterval(stepperValue * t))
            }
        }
    }
    
    
    
    private func timeString(time: TimeInterval) -> String {
      let hour = Int(time) / 3600
      let minute = Int(time) / 60 % 60
      // return formated string
      if hour == 0 {
        return String(format: "%2im", minute)
      }else {
        return String(format: "%2ih %2im", hour, minute)
        
      }
    }
    
    private func setupItem() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.sendeValueDelegate?.addTargetsenderValueDelegate(Int(self?.addTargetStepper.value ?? 0))
        }
        
        contentView.addSubview(addTargetView)
        addTargetView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        addTargetView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        addTargetView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        addTargetView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addTargetView.addSubview(addTargetLabel)
        addTargetLabel.leadingAnchor.constraint(equalTo: addTargetView.leadingAnchor, constant: 15).isActive = true
        addTargetLabel.centerYAnchor.constraint(equalTo: addTargetView.centerYAnchor).isActive = true
        
        addTargetView.addSubview(addTargetStepper)
        addTargetStepper.centerXAnchor.constraint(equalTo: addTargetView.centerXAnchor).isActive = true
//        addTargetStepper.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120).isActive = true
        addTargetStepper.centerYAnchor.constraint(equalTo: addTargetView.centerYAnchor).isActive = true
        addTargetStepper.addTarget(self, action: #selector(addTargetValue(_:)), for: .valueChanged)
        
        addTargetView.addSubview(targetTime)
        targetTime.centerYAnchor.constraint(equalTo: addTargetView.centerYAnchor).isActive = true
        targetTime.trailingAnchor.constraint(equalTo: addTargetView.trailingAnchor, constant: -10).isActive = true
    }
    
}
