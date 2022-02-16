//
//  BarChartView.swift
//  FocusTimeBarChart
//
//  Created by Brian Voong on 4/29/19.
//  Copyright © 2019 Brian Voong. All rights reserved.
//

import UIKit

class BarChartView: UIView {
   
//
//    let titleLabel = UILabel(text: "Focus Time", font: .systemFont(ofSize: 16, weight: .semibold), textColor: #colorLiteral(red: 0.03687004, green: 0.1071577296, blue: 0.3541871309, alpha: 1))
//    let barChartController = BarChartController(scrollDirection: .horizontal)
//    lazy var barsContainerView: UIView = {
//        let v = UIView()
//        v.stack(views: self.titleLabel, self.barChartController.view, spacing: 12)
////        barChartController.update(inttt: aa!)
//        return v
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        backgroundColor = .red
//        layer.cornerRadius = 8
//        
//        setupShadow(opacity: 0.05, radius: 8, offset: .init(width: 0, height: 12), color: .black)
//        
//        stack(views: titleLabel, barsContainerView, spacing: 12).withMargins(.init(top: 16, left: 0, bottom: 12, right: 16))
//    }
//    
//    fileprivate func setupBars() {
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError()
//    }
//    
//    func update(timeArray: [Int], days: Int, timerTime: Int) {
//        self.barChartController.update(timeArray: timeArray, days: days, timerTime: timerTime)
//    }
//    
//}
//
//struct BarData {
//    let index: Int
//    let percentage: CGFloat
//    let color: UIColor
//}
//
//class BarChartCell: GenericCell<BarData> {
//    
//    let indexLabel = UILabel(text: "12", font: .systemFont(ofSize: 10, weight: .regular), textColor: .lightGray, textAlignment: .center)
//    
//    lazy var barTrackView: UIView = {
//        let v = UIView()
//        v.backgroundColor = UIColor.orange
//        v.layer.cornerRadius = 3
//        
//        v.addSubview(self.barFillView)
////        barFillView.topAnchor.constraint(equalTo: v.topAnchor).isActive = true
////        barFillView.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 0).isActive = true
////        barFillView.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: 0).isActive = true
////        barFillView.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0).isActive = true
//        self.barFillView.anchor(top: nil, leading: v.leadingAnchor, bottom: v.bottomAnchor, trailing: v.trailingAnchor)
//        
//        self.barFillHeightConstraint = self.barFillView.heightAnchor.constraint(equalTo: v.heightAnchor)
//        self.barFillHeightConstraint.isActive = true
//        return v
//    }()
//    
//    var barFillHeightConstraint: NSLayoutConstraint!
//    
//    let barFillView: UIView = {
//        let v = UIView()
//        v.backgroundColor = .red
//        v.layer.cornerRadius = 4
//        return v
//    }()
//    
//    let dotView = UIView(backgroundColor: #colorLiteral(red: 0.8062210083, green: 0.8068378568, blue: 0.8063165545, alpha: 1))
//    
//    override var item: BarData! {
//        didSet {
//            indexLabel.textColor = item.index % 7 == 0 ? .lightGray : .clear
//            indexLabel.text = String(item.index)
//            
//            if item.index % 7 == 0 {
//                dotViewHeightConstraint.constant = 6
//                dotViewWidthConstraint.constant = 6
//                dotView.layer.cornerRadius = 4
//            } else {
//                dotViewHeightConstraint.constant = 4
//                dotViewWidthConstraint.constant = 4
//                dotView.layer.cornerRadius = 2
//            }
//            
//            barFillHeightConstraint.isActive = false
//            self.barFillHeightConstraint = self.barFillView.heightAnchor.constraint(equalTo: barTrackView.heightAnchor, multiplier: item.percentage)
//            self.barFillHeightConstraint.isActive = true
//            self.barFillView.backgroundColor = item.color
//        }
//    }
//    
//    var dotViewContainer = UIView().withHeight(height: 24)
//    var dotViewHeightConstraint: NSLayoutConstraint!
//    var dotViewWidthConstraint: NSLayoutConstraint!
//    
//    override func setupViews() {
//        super.setupViews()
//       
//        clipsToBounds = false
//        stack(views:
//            stack(.horizontal, views:
//                UIView().withWidth(4),
//                barTrackView,
//                UIView().withWidth(4)),
//              dotViewContainer,
//              indexLabel, spacing: 0)
//        
//        dotViewContainer.addSubview(dotView)
//        dotView.centerInSuperview()
//        dotViewWidthConstraint = dotView.widthAnchor.constraint(equalToConstant: 0)
//        dotViewHeightConstraint = dotView.heightAnchor.constraint(equalToConstant: 0)
//        dotViewWidthConstraint.isActive = true
//        dotViewHeightConstraint.isActive = true
//        
//        dotView.centerXAnchor.constraint(equalTo: indexLabel.centerXAnchor).isActive = true
//    }
//}
//
//class BarChartController: GenericController<BarChartCell, BarData, UICollectionReusableView>, UICollectionViewDelegateFlowLayout {
//    private lazy var days = 7
//    private lazy var timeDayArray = [Int]()
//    private lazy var timerTime = 0
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       
//    }
//    
//    func update(timeArray: [Int],  days: Int, timerTime: Int) {
//        self.days = days
//        timeDayArray.removeAll()
//        timeDayArray = timeArray
//        self.timerTime = timerTime
//        edit()
//    }
//    
//    func edit() {
//        items.removeAll()
//        (1...days).forEach { (i) in
//            let color: UIColor
//            color = .black
//            let value = calculatePercentage(value: Double(timeDayArray[i - 1]),percentageVal: 100, timerTime: Double(timerTime))
//            
//            let formatter = NumberFormatter()
//            formatter.numberStyle = .decimal
//            formatter.maximumFractionDigits = 2
//            formatter.decimalSeparator = ""
//            formatter.groupingSeparator = ""
//            
//            let number = NSNumber(value: value)
//            let formatt = formatter.string(from: number)!
//            print("FORMATT == \(number)")
//            
//            print(String(formatt).PadLeft(totalWidth: 2, byString: ".0"))
////            let aa = Float(String(formatt).PadLeft(totalWidth: 2, byString: ".0"))!
//            items.append(.init(index: i, percentage: CGFloat(0.0911), color: color))
//        }
//        collectionView.reloadData()
//
//        collectionView.backgroundColor = .white
//    }
//    
//    public func calculatePercentage(value:Double,percentageVal:Double, timerTime: Double)->Double {
//        let val = value * percentageVal
//        return val / timerTime
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return .init(width: 15, height: view.frame.height)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
}
