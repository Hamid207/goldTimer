//
//  MainCollectionViewCelll.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

class MainCollectionViewCelll: UICollectionViewCell {
    
    var progressBar: ProgressBar!
    
    weak var timerStartStopDelegate: TimerStartStopDelegate?
    weak var setIndexDeleagte: SetIndexDelegate?
    weak var addModelIndexDelegate: AddModelIndexDelegate?
    weak var setTimerUpdateTimeDeleagte: SetTimerUpdateTimeDelegate?
    weak var setPomodoroTimerUpdateTimeDeleagte: SetPomdoroTimerUpdateTimeDelegate?
    weak var removeTimerDelegate: TimerRemoveDelegate?
    weak var pomodoroTimerStartStopDelegate: PomodoroTimerStartStopDelegate?
    weak var sentAlertActionDelegate: SentAlertActionDelegate?
    
    
    var index: Int?
    var timerRemoveIndex: TimerModelData?
    
    private var timerCellColor: String?
    
    private var timerTime: Int?
    private var startTime: Date?
    private var stopTime: Date?
    private lazy var timerCounting:Bool = false
    private lazy var timerDoneSelected: Bool = false
    
    private var isPomodoroTimerOnOff: Bool?
    private lazy var pomodoroTime: Int? = 0
    private lazy var pomodoroTimeUpdate = 0
    private lazy var pomodoroWorkTime = 10
    private lazy var pomodoroBreakTime = 5
    private lazy var isPomodorTimerWorkOrBreak:Bool = true
    private var pomodoroStartTime: Date?
    private var pomodoroStopTime: Date?
    private lazy var pomodoroUpdateWorkTime = 0
    private lazy var pomodoroUpdateBreakTime = 0
    
    private lazy var timerUpdateTime = 0
    //    private lazy var timerStart:Bool = false
    
    private lazy var removeBool: Bool = false
    
    private var weekDay: Int?
    private var toDay: Int?
    private var misStartTime: Date?
    private var misStopTime: Date?
    
    private weak var timer: Timer? {
        willSet {
            timer?.invalidate()// bashqa vcye girende ve sora yenined qayidanda timeri pause elemek olmurdu cunki herdefe yeni timer yaradirdi bu onun qarshisin alir
        }
    }
    private weak var pomodoroTimer: Timer? {
        willSet {
            pomodoroTimer?.invalidate()
        }
    }
    
    private var isFirstAnimation = true
    private var animteBool: Bool = false
    private var circularBarReload = false
    private var circulerStartStopTime: Float?
    var countFred: CGFloat = 0
    
    //===============================================
    
    private let removeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "trash.fill")
        imageView.tintColor = .black
        //        imageView.backgroundColor = .red
        return imageView
    }()
    
    private let removeTimer: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //        button.backgroundColor = .red
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
//        label.backgroundColor = .red
        return label
    }()
    
    private let timerLabelAndProfressUIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        //        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 50, weight: .medium)
//        label.backgroundColor = .yellow
        return label
    }()
    
    private let pomodoroTimerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 50, weight: .bold)
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
//        button.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupItem()
//        let startDate = Date()
//        let endDate: Date = {
//            let component = DateComponents(day: 1, second: -1 )
//            return Calendar.current.date(byAdding: component, to: startDate)!
//        }()
//        print("START DATE == \(startDate) END DATE == \(endDate)")
    }
    
//    func calendarr(didSelect date: Date) {
//
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSub()
    }
    
    //MARK: - Update
    func update(model: TimerModelData, timerCounting: Bool, index: Int, checkDay: Int) {
        self.weekDay = checkDay
        weekDayAdd()
        timerTime = model.timerTime
        timerCellColor = model.name
        timerUpdateTime = model.timerUpdateTime
        nameLabel.text = model.name
        startTime = model.startTimer
        stopTime = model.stopTimer
        self.timerCounting = model.timerCounting
        self.index = index
        timerDoneSelected = model.timerDone
        isPomodoroTimerOnOff = model.pomodoroTimerOnOff
        if model.pomodoroTimerOnOff == true {
            pomodoroStartTime = model.pomdoroStartTime
            pomodoroStopTime = model.pomdoroStopTime
            guard let workOrBreak = model.pomodorTimerWorkOrBreak else { return }
            isPomodorTimerWorkOrBreak = workOrBreak
            //            if isPomodorTimerWorkOrBreak == true {
            //                pomodoroUpdateWorkTime = model.pomodoroTimerUpdateTime
            //            }else if isPomodorTimerWorkOrBreak == false{
            //                pomodoroUpdateBreakTime = model.pomodoroTimerUpdateTime
            //            }
        }
//        progressBar.firstAnimation(value: 0.0)
        addModelIndexDelegate?.addModelIndex(index: index)
        autoStart()
    }
    
    //MARK: - Auto start
    private func autoStart() {
        //        if isPomodoroTimerOnOff == true {
        //            if isPomodorTimerWorkOrBreak == true {
        //                setPomodoroTimeLabel(pomodoroUpdateWorkTime)
        //                print("WORK TIME === \(pomodoroUpdateWorkTime)")
        //            }else {
        //                setPomodoroTimeLabel(pomodoroUpdateBreakTime)
        //                print("BRAK TIME === \(pomodoroUpdateBreakTime)")
        //            }
        //        }else {
        //            pomodoroTimerLabel.text = ""
        //        }
        if timerCounting {
            setTimerCounting(true)
            startTimer()
            setIndexDeleagte?.setIndex(index: self.index)
//            if isFirstAnimation == true {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
//                    self.progressBar.firstAnimation(value: 0.5)
//                    self.isFirstAnimation = false
//                }
//            }
        }else {
            setTimerCounting(false)
            stopTimer()
//            if timerDoneSelected == true && toDay == weekDay {
//                timerDone()
//            }else {
//                stopTimer()
//            }

            if toDay == weekDay {
                setTimeLabel(timerUpdateTime)
            }else {
                setTimeLabel(timerTime!)
            }
            
            if let start = startTime {
                if let stop = stopTime {
                    let time = calcRestartTime(start: start, stop: stop)
                    let diff = Date().timeIntervalSince(time)//burda startdan stopa nece saniye kecib onu gosterir ama bu burda lazim deyil
                    //                    setTimeLabel(Int(diff))
                }
            }
        }
    }
    
    //MARK: - StartStopButtonAction
    @objc private func startStopButtonAction() {
        if timerCounting {
            setStopTime(date: Date())
            pomodoroStopTime = Date()
            //            stopTimer()
            setTimerCounting(false)
            if toDay == weekDay {
                timerStartStopDelegate?.timerStartStop(index: index, timerCounting: timerCounting, startTime: startTime, stopStime: stopTime)
            }else {
                sentAlertActionDelegate?.sentAlert()
            }
//            progressBar.pauseAnimation()
            
        }else {
            misStopTime = stopTime
            misStartTime = startTime
            if let stop = stopTime {
                let restartTime = calcRestartTime(start: startTime!, stop: stop)
                setStopTime(date: nil)
                setStartTime(date: restartTime)
            }else {
                setStartTime(date: Date())
            }
            //            startTimer()
            setTimerCounting(true)
            if toDay == weekDay {
                timerStartStopDelegate?.timerStartStop(index: index, timerCounting: timerCounting, startTime: startTime, stopStime: stopTime)
            }else {
                sentAlertActionDelegate?.sentAlert()
            }
        }
    }
    
    //MARK: - Start timer
    func startTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
        self.timer = timer
        //        setTimerCounting(true)
        removeBool = true
        if toDay == weekDay {
            startButton.setTitle("Pause", for: .normal)
            startButton.backgroundColor = .white
            startButton.setTitleColor(.black, for: .normal)
        }else {
            startButton.setTitle("Start", for: .normal)
            startButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            startButton.setTitleColor(.white, for: .normal)
        }
        
        
        //circular bar
//        if animteBool == false {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.27) {
////                self.progressBar.firstAnimation(value: self.updateCircularBar())
//                self.progressBar.basicAnimationFunc()
//                self.progressBar.resumeAnimation()
//                self.animteBool = true
//                print("AAAAAAAAAA")
//            }
//        }else {
//            print("CELL RESUMEE")
//            progressBar.resumeAnimation()
//        }
    }
    
    //MARK: - Stop timer
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        removeBool = false
        //        setTimerCounting(false)
        if toDay == weekDay {
            startButton.setTitle("Start", for: .normal)
            startButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            startButton.setTitleColor(.white, for: .normal)
        }else {
            startButton.setTitle("Start", for: .normal)
            startButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            startButton.setTitleColor(.white, for: .normal)
        }
    }
    
    private func timerDone() {
        startButton.setTitle("Done", for: .normal)
        startButton.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        startButton.setTitleColor(.black, for: .normal)
    }
    
    //MARK: MisTimer
    func missTimer() {
        setStopTime(date: misStopTime)
        setStartTime(date: misStartTime)
        setTimerCounting(false)
    }
    
    @objc private func timerRemove() {
        guard let modelIndex = timerRemoveIndex else { return }
        removeTimerDelegate?.removeIndex(modelIndex: modelIndex, deleteBool: removeBool, cellIndex: index!)
    }
    
    func timerIsRemove() {
        setStartTime(date: nil)
        setStopTime(date: nil)
    }
    
    //MARK: - Refresh Value
    @objc private func refreshValue() {
        weekDayAdd()
        if let start = startTime, let timerTime = timerTime {
            let diff = start.timeIntervalSince(Date(timeIntervalSinceNow: TimeInterval(-timerTime)))
            //            let diff = Date().timeIntervalSince(start)
            if toDay == weekDay {
                setTimeLabel(Int(diff))
            }else {
                setTimeLabel(timerTime)
            }
            setTimerUpdateTimeDeleagte?.setTimerNewTime(newTime: Int(diff), index: index!)
            if Int(diff) <= 0 {
                stopTimer()
//                if toDay == weekDay {
//                    timerDone()
//                }
                setTimerCounting(false)
                setTimeLabel(self.timerTime!)
                setStartTime(date: nil)
                setStopTime(date: nil)
                animteBool = false
            }
        }
    }
    
    private func calcRestartTime(start: Date, stop: Date) -> Date {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    
    //timer label add timer
    private func setTimeLabel(_ val: Int) {
        let time = secondsToHoursMinutesSeconds(val)
        let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
        timerLabel.text = timeString
    }
    
    private func secondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int) {
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        return (hour, min, sec)
    }
    
    private func makeTimeString(hour: Int, min: Int, sec: Int) -> String {
        var timeString = ""
        timeString += String(format: "%2d", hour)
        timeString += ":"
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        return timeString
    }
    
//    private func updateCircularBar() -> Float {
//        var bbb = String()
//        if let timerTimeee = timerTime {
//            let aaa = timerTimeee - timerUpdateTime
//            bbb = String(format:"%.02f", Float(aaa * 100) / Float(timerTimeee))
////            circulerStartStopTime = Float(bbb)
//            print("TIMER TIME UPDATE == \(bbb)")
//
//        }
//        print("BBBBBBBBB === \(bbb)")
//        return Float(bbb)!
//    }
    
    private func setStartTime(date: Date?) {
        startTime = date
    }
    
    private func setStopTime(date: Date?) {
        stopTime = date
    }
    
    private func setTimerCounting(_ val: Bool) {
        timerCounting = val
    }
    
    //MARK: - Week Day yeni bugun necenci gundu
    private func weekDayAdd() {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let today = Calendar.current.component(.weekday, from: date)
        self.toDay = today
    }
   
    //MARK: - Setup Item
    private func setupItem() {
        contentView.addSubview(removeImageView)
        removeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        removeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        removeImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        removeImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        contentView.addSubview(removeTimer)
        removeTimer.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        removeTimer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        removeTimer.heightAnchor.constraint(equalToConstant: 35).isActive = true
        removeTimer.widthAnchor.constraint(equalToConstant: 35).isActive = true
        removeTimer.addTarget(self, action: #selector(timerRemove), for: .touchDown)
        
        contentView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
//        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
        
//        progressBar = ProgressBar()
//        contentView.addSubview(progressBar)
//        progressBar.translatesAutoresizingMaskIntoConstraints = false
//        progressBar.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
//        progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
//        progressBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
        
        //        contentView.addSubview(timerLabelAndProfressUIView)
        //        timerLabelAndProfressUIView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        //        timerLabelAndProfressUIView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        //        timerLabelAndProfressUIView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        //        timerLabelAndProfressUIView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100).isActive = true
        //
        contentView.addSubview(timerLabel)
        timerLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        timerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        
        contentView.addSubview(startButton)
        startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        startButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        startButton.addTarget(self, action: #selector(startStopButtonAction), for: .touchUpInside)
        
        contentView.addSubview(pomodoroTimerLabel)
        pomodoroTimerLabel.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -20).isActive = true
        pomodoroTimerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        pomodoroTimerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
    }
    
    private func layoutSub() {
//        self.backgroundColor = #colorLiteral(red: 0.08406862617, green: 0.7534314394, blue: 0.5585784912, alpha: 1)
        switch timerCellColor {
            case "red": self.backgroundColor = UIColor.red
            case "yellow": self.backgroundColor = .yellow
            case "green": self.backgroundColor = .green
            case "gray": self.backgroundColor = .gray
            case "blue": self.backgroundColor = .blue
            default:
                self.backgroundColor = #colorLiteral(red: 0.08406862617, green: 0.7534314394, blue: 0.5585784912, alpha: 1)
        }
        
        self.layer.cornerRadius = 10
        startButton.layer.cornerRadius = 10
    }
    
    
    //MARK: - Pomodoro Timer
//    private func pomodoroTimerStart() {
//        let pomodoroTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshPomodoroValue), userInfo: nil, repeats: true)
//        RunLoop.current.add(pomodoroTimer, forMode: .common)
//        pomodoroTimer.tolerance = 0.1
//        self.pomodoroTimer = pomodoroTimer
//
//        print("START")
//    }
//
//    @objc private func refreshPomodoroValue() {
//        if let pomodoroStartTime = pomodoroStartTime {
//            if isPomodorTimerWorkOrBreak == true {
//                let pomodoroDiff = pomodoroStartTime.timeIntervalSince(Date(timeIntervalSinceNow: TimeInterval(-pomodoroWorkTime )))
//                setPomodoroTimeLabel(Int(pomodoroDiff))
//                //                print("111111 === \(Int(pomodoroDiff))")
//                if pomodoroDiff <= 0 {
//                    isPomodorTimerWorkOrBreak = false
//                    self.pomodoroStartTime = Date()
//                    print("111111 === \(Int(pomodoroDiff))")
//                }
//                setPomodoroTimerUpdateTimeDeleagte?.setPomodoroNewTime(newTime: Int(pomodoroDiff), pomdoroTimerBreakOrWork: isPomodorTimerWorkOrBreak, index: index!)
//            }else {
//                let pomodoroDiff = pomodoroStartTime.timeIntervalSince(Date(timeIntervalSinceNow: TimeInterval(-pomodoroBreakTime )))
//                setPomodoroTimeLabel(Int(pomodoroDiff))
//                //                print("22222 === \(Int(pomodoroDiff))")
//                if pomodoroDiff <= 0 {
//                    isPomodorTimerWorkOrBreak = true
//                    self.pomodoroStartTime = Date()
//                    print("22222 === \(Int(pomodoroDiff))")
//                }
//                setPomodoroTimerUpdateTimeDeleagte?.setPomodoroNewTime(newTime: Int(pomodoroDiff), pomdoroTimerBreakOrWork: isPomodorTimerWorkOrBreak, index: index!)
//            }
//        }
//    }
//
//    private func setPomodoroTimeLabel(_ val: Int) {
//        let time = secondsToHoursMinutesSeconds(val)
//        let pomodoroTimeString = makePomodoroTimeString(min: time.1, sec: time.2)
//        pomodoroTimerLabel.text = pomodoroTimeString
//    }
//
//    private func makePomodoroTimeString(min: Int, sec: Int) -> String {
//        var timeString = ""
//        timeString += String(format: "%02d", min)
//        timeString += ":"
//        timeString += String(format: "%02d", sec)
//        return timeString
//    }
    
}

