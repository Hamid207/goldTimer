//
//  AddNewTimerTableViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

class AddNewTimerTableViewCell: UITableViewCell {
    
    weak var addTimerDelegate: TimerItemAddDelegate?
    
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
    
    @objc private func saveButtonTarget() {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let weekday = Calendar.current.component(.weekday, from: date)
//        if hourse != 0 || minute != 0 || seconds != 0  {
//            let timeee = hourse * 3600 + minute * 60 + seconds
//            let timerModel = TimerModelData(name: nameTextField.text, timerTime: timeee, timerColor: nameTextField.text, hourse: hourse, minute: minute, seconds: seconds, statick: timeee, pomodoroTime: pomodoroTime, pomodoroTimerOnOff: isPomodoroTimerOnOff, pomodorTimerWorkOrBreak: true,  startFix: false, bugFixBool: false, userTimerstatistics: 0, startTimer: nil, stopTimer: nil, timerCounting: false, timerUpdateTime: timeee, pomodoroTimerUpdateTime: pomodoroTime!, pomdoroStartTime: nil, pomdoroStopTime: nil, todayDate: Date().getFormattedDate(), weekDay: weekday, timer24houresResetOnOff: isTimer24HoursResetOnOff, mon: tapWeekDayArray[1]!, tue: tapWeekDayArray[2]!, wed: tapWeekDayArray[3]!, thu: tapWeekDayArray[4]!, fri: tapWeekDayArray[5]!, sat: tapWeekDayArray[6]!, sun: tapWeekDayArray[7]!, timerDone: false)
//            addTimerDelegate?.timerAdd(timer: timerModel)
//        }else {
//
//        }
    }
    
    func update(color: UIColor?) {
        
    }
    
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
