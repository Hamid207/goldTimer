//
//  TimerDetailTableViewCell.swift
//  GoldTime
//
//  Created by Hamid Manafov on 21.01.22.
//

import UIKit

class TimerDetailTableView: UITableViewCell {
    
    weak var pushhDelegate: PushTimerDetailVCDelegate?
    weak var timerStatisticsDelegate: SentTimerStatisticDelegate?
    
    var index: Int?
    private var statistics = 7
    private var userTimerStatistic: Int?
    private let barChartView = BarChartView()

    private let timerDetailStatictic: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "Time Statistic"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    private let weekStatisticsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.text = "7 days:  12:12:12"
        return label
    }()
    
    private let monthStatisticsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.text = "30 day: 12:12:12"
        return label
    }()
    
    private let threeMonthStatisticsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.text = "90 day: 12:12:12"
        return label
    }()
    
    private let sixMonthStatisticsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.text = "180 day: 12:12:12"
        label.backgroundColor = .red
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
    
    //statisticTargetlabel
    private var statisticTargetlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 55, weight: .heavy)
//        label.text = "12h 25m 30s"
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
        //        self.backgroundColor = #colorLiteral(red: 0.08406862617, green: 0.7534314394, blue: 0.5585784912, alpha: 1)
        //        self.layer.cornerRadius = 10
    }
    
    
    func update(statisticsTime: Int?, timeArray: [Int], timerTime: Int){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let time = statisticsTime else { return }
            self.statisticTargetlabel.text = self.timeString(time: TimeInterval(time))
//            self.barChartView.update(timeArray: timeArray, days: self.statistics, timerTime: timerTime)
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
    
    func itemSetup() {
//        contentView.addSubview(weekStatisticsLabel)
//        weekStatisticsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
//        weekStatisticsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
//        weekStatisticsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
//
//        contentView.addSubview(monthStatisticsLabel)
//        monthStatisticsLabel.topAnchor.constraint(equalTo: weekStatisticsLabel.bottomAnchor, constant: 10).isActive = true
//        monthStatisticsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
//        monthStatisticsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
//
//        contentView.addSubview(threeMonthStatisticsLabel)
//        threeMonthStatisticsLabel.topAnchor.constraint(equalTo: monthStatisticsLabel.bottomAnchor, constant: 10).isActive = true
//        threeMonthStatisticsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
//        threeMonthStatisticsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
//
//        contentView.addSubview(sixMonthStatisticsLabel)
//        sixMonthStatisticsLabel.topAnchor.constraint(equalTo: threeMonthStatisticsLabel.bottomAnchor, constant: 10).isActive = true
//        sixMonthStatisticsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
//        sixMonthStatisticsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
//        contentView.addSubview(timerDetailStatictic)
//        timerDetailStatictic.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
//        //        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        timerDetailStatictic.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
//        //        timerDetailStatictic.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
//        //        timerDetailStatictic.heightAnchor.constraint(equalToConstant: 30).isActive = true
//
//        contentView.addSubview(timerLabel)
//        timerLabel.topAnchor.constraint(equalTo: timerDetailStatictic.topAnchor).isActive = true
//        timerLabel.leadingAnchor.constraint(equalTo: timerDetailStatictic.trailingAnchor, constant: 5).isActive = true
//        timerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
//        //        timerLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
//
        contentView.addSubview(statisticsSegmetControll)
        statisticsSegmetControll.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        statisticsSegmetControll.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        statisticsSegmetControll.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        statisticsSegmetControll.addTarget(self, action: #selector(didCgangeStatisticSegment), for: .valueChanged)

        contentView.addSubview(statisticTargetlabel)
        statisticTargetlabel.topAnchor.constraint(equalTo: statisticsSegmetControll.bottomAnchor, constant: 20).isActive = true
        statisticTargetlabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        statisticTargetlabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        
//        contentView.addSubview(barChartView)
//        barChartView.translatesAutoresizingMaskIntoConstraints = false
//        barChartView.backgroundColor = .clear
//        barChartView.topAnchor.constraint(equalTo: statisticTargetlabel.bottomAnchor, constant: 20).isActive = true
//        barChartView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
//        barChartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
//        barChartView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
