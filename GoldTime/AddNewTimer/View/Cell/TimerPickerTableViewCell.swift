//
//  TimerPickerTableViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 28.01.22.
//

import UIKit

final class TimerPickerTableViewCell: UITableViewCell {
    
    weak var sentTimerTimeDelegate: SentTimerTimeDelegate?
    
    private lazy var hourse: Int = 0
    private lazy var minute: Int = 15
//    private lazy var seconds: Int = 0
    
    private lazy var hourseArray = [Int](0...10)
    private lazy var minuteArray = [Int](0...60)
//    private lazy var secundArray = [Int](0...60)
    
    private let viewPicker: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let timerPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
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
        viewPicker.backgroundColor = .white
        viewPicker.layer.cornerRadius = 10
    }
    
    private func itemSetup() {
        timerPickerView.delegate = self
        timerPickerView.dataSource = self
        
        contentView.addSubview(viewPicker)
        viewPicker.topAnchor.constraint(equalTo: topAnchor).isActive = true
        viewPicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        viewPicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        viewPicker.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        viewPicker.addSubview(timerPickerView)
        timerPickerView.topAnchor.constraint(equalTo: viewPicker.topAnchor).isActive = true
        timerPickerView.leadingAnchor.constraint(equalTo: viewPicker.leadingAnchor, constant: 0).isActive = true
        timerPickerView.trailingAnchor.constraint(equalTo: viewPicker.trailingAnchor, constant: 0).isActive = true
        timerPickerView.bottomAnchor.constraint(equalTo: viewPicker.bottomAnchor).isActive = true
        timerPickerView.selectRow(15, inComponent: 4, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            self.sentTimerTimeDelegate?.sentTimerTime(h: self.hourse, m: self.minute)
        }
    }
}

extension TimerPickerTableViewCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
            case 0: return 0
            case 1: return 0
            case 2: return 10
            case 3: return 1
            case 4: return 60
            case 5: return 1
            default:
                return 0
        }
    }
}

extension TimerPickerTableViewCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
//            case 0:
//                return String(hourseArray[row])
//            case 1:
//                let hour = UILabel()
//                hour.text = "hour"
//                timerPickerView.setPickerLabels(labels: [1:hour], containedView: viewPicker)
//                return ""
            case 2:
                return String(hourseArray[row])
            case 3:
                let hour = UILabel()
                hour.text = "hour"
                timerPickerView.setPickerLabels(labels: [3:hour], containedView: viewPicker)
                return ""
            case 4:
                return String(minuteArray[row])
            case 5:
                let min = UILabel()
                min.text = "min"
                timerPickerView.setPickerLabels(labels: [5:min], containedView: viewPicker)
                return ""
            default:
                return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        hourse = (pickerView.selectedRow(inComponent: 0))
        hourse = (pickerView.selectedRow(inComponent: 2))
        minute = (pickerView.selectedRow(inComponent: 4))
        sentTimerTimeDelegate?.sentTimerTime(h: hourse, m: minute)
    }
}

