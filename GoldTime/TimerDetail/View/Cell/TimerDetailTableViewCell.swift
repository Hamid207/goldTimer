//
//  TimerDetailTableViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

final class TimerDetailTableView: UITableViewCell {
    
    weak var pushhDelegate: PushTimerDetailVCDelegate?
    weak var timerStatisticsDelegate: SentTimerStatisticDelegate?
    
    var index: Int?
    private var statistics = 7
    private var userTimerStatistic: Int?
    //  private let barChartView = BarChartView()
    
    private let staticsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.text = "Stats"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    //timerLabel
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    //segmentControll
    private let statisticsSegmetControll: UISegmentedControl = {
        var segmentControllArray = ["7 day", "30 day", "3 month", "6 month"]
        let segment = UISegmentedControl(items: segmentControllArray)
        segment.selectedSegmentIndex = 0
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    private let statisticTargetUIView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    //statisticTargetlabel
    private var statisticTargetlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        //    label.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
        label.font = UIFont.init(name: "Hiragino Maru Gothic ProN", size: 45)
        //            label.text = "123h 25m 30s"
        return label
    }()
    
    private let targetDoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.init(name: "Hiragino Maru Gothic ProN", size: 30)
        label.text = "1/15"
        return label
    }()
    
    private let targetHourseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.init(name: "Hiragino Maru Gothic ProN", size: 30)
        label.text = "3h 25m"
        return label
    }()
    
    
    private func timeString(time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        // return formated string
        if hour == 0 {
            return String(format: "%02im %02is", minute, second)
        }else {
            return String(format: "%02ih %02im %02is", hour, minute, second)
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        itemSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        statisticTargetUIView.layer.cornerRadius = 10.0
        statisticTargetUIView.setupShadow(opacity: 0.2, radius: 10, offset: .init(width: 0, height: 0), color: .black)
    }
    
    
    func update(statisticsTime: Int?, timeArray: [Int], timerTime: Int, userTarget: Int, timerDone: Int){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let time = statisticsTime else { return }
            self.statisticTargetlabel.text = self.timeString(time: TimeInterval(time))
            self.targetDoneLabel.text = "\(timerDone)/\(userTarget)"
            let timerTime = userTarget * timerTime
            self.targetHourseLabel.text = self.timeStringTarget(time: TimeInterval(timerTime))
            //            self.barChartView.update(timeArray: timeArray, days: self.statistics, timerTime: timerTime)
        }
    }
    
    private func timeStringTarget(time: TimeInterval) -> String {
      let hour = Int(time) / 3600
      let minute = Int(time) / 60 % 60
      // return formated string
      if hour == 0 {
        return String(format: "%2im", minute)
      }else if minute == 0 {
        return String(format: "%2ih", hour)
      }else {
        return String(format: "%2ih%2im", hour, minute)
        
      }
    }
    
    
    @objc private func didCgangeStatisticSegment(_ sender: UISegmentedControl) {
        if sender == self.statisticsSegmetControll {
            switch sender.selectedSegmentIndex {
                case 0: timerStatisticsDelegate?.sentTimerStatisticDelegate(days: .week)
                    statistics = 7
                case 1: timerStatisticsDelegate?.sentTimerStatisticDelegate(days: .month)
                    statistics = 30
                case 2: timerStatisticsDelegate?.sentTimerStatisticDelegate(days: .threeMonth)
                    statistics = 90
                case 3: timerStatisticsDelegate?.sentTimerStatisticDelegate(days: .sixMonth)
                    statistics = 180
                default: break
            }
        }
    }
    
    private  func itemSetup() {
        
        addSubview(staticsLabel)
        staticsLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        staticsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        staticsLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        contentView.addSubview(statisticsSegmetControll)
        statisticsSegmetControll.topAnchor.constraint(equalTo: staticsLabel.bottomAnchor, constant: 10).isActive = true
        statisticsSegmetControll.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        statisticsSegmetControll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        statisticsSegmetControll.addTarget(self, action: #selector(didCgangeStatisticSegment), for: .valueChanged)
        
        contentView.addSubview(statisticTargetUIView)
        statisticTargetUIView.topAnchor.constraint(equalTo: statisticsSegmetControll.bottomAnchor, constant: 20).isActive = true
        statisticTargetUIView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        statisticTargetUIView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        statisticTargetUIView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        statisticTargetUIView.addSubview(statisticTargetlabel)
        statisticTargetlabel.topAnchor.constraint(equalTo: statisticTargetUIView.topAnchor, constant: 20).isActive = true
        //    statisticTargetlabel.centerYAnchor.constraint(equalTo: statisticTargetUIView.centerYAnchor).isActive = true
        statisticTargetlabel.centerXAnchor.constraint(equalTo: statisticTargetUIView.centerXAnchor).isActive = true
        
        statisticTargetUIView.addSubview(targetDoneLabel)
        targetDoneLabel.topAnchor.constraint(equalTo: statisticTargetlabel.bottomAnchor, constant: 50).isActive = true
        targetDoneLabel.leadingAnchor.constraint(equalTo: statisticTargetUIView.leadingAnchor, constant: 25).isActive = true
        
        
        statisticTargetUIView.addSubview(targetHourseLabel)
        targetHourseLabel.centerYAnchor.constraint(equalTo: targetDoneLabel.centerYAnchor).isActive = true
        targetHourseLabel.trailingAnchor.constraint(equalTo: statisticTargetUIView.trailingAnchor, constant: -25).isActive = true
    }
}
