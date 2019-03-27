//
//  ChartsViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/26/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    var account: Account = Account()
    lazy var barChartView: BarChartView = BarChartView()
    lazy var lineChartView: LineChartView = LineChartView()
    
    override func setupView() {
        super.setupView()
        updateChartWithData()
        createLineChart()
    }
    
    private func updateChartWithData() {
        contentView.addSubview(barChartView)
        barChartView.setConstraints(topAnchor: contentView.topAnchor, leadingAnchor: contentView.leadingAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: 16, leadingConstant: 16, trailingConstant: -16)
        barChartView.heightAnchor.constraint(equalTo: barChartView.widthAnchor).isActive = true
        
        var incomeDataEntries: [BarChartDataEntry] = []
        let income = RealmManager.shared.getSum(ofType: Movement.self, property: "amount", filter: "account.id == '\(account.id)' AND type == '\(Movement.MovementType.income.rawValue)'")
        let outcome = RealmManager.shared.getSum(ofType: Movement.self, property: "amount", filter: "account.id == '\(account.id)' AND type == '\(Movement.MovementType.outcome.rawValue)'")
        
        let incomeDataEntry = BarChartDataEntry(x: 1, y: income)
        incomeDataEntries.append(incomeDataEntry)
        
        var outcomeDataEntries: [BarChartDataEntry] = []
        let outcomeDataEntry = BarChartDataEntry(x: 2, y: outcome)
        outcomeDataEntries.append(outcomeDataEntry)
        
        let incomeChartDataSet = BarChartDataSet(values: incomeDataEntries, label: "Income")
        incomeChartDataSet.setColor(UIColor("#52C6A7"))
        let outcomeChartDataSet = BarChartDataSet(values: outcomeDataEntries, label: "Outcome")
        outcomeChartDataSet.setColor(UIColor("FD2D55"))
        let chartData = BarChartData(dataSets: [incomeChartDataSet, outcomeChartDataSet])
        barChartView.data = chartData
        barChartView.xAxis.labelTextColor = ThemeManager.currentTheme().textColor
        barChartView.getAxis(.left).labelTextColor = ThemeManager.currentTheme().textColor
        barChartView.getAxis(.right).labelTextColor = ThemeManager.currentTheme().textColor
        barChartView.legend.textColor = ThemeManager.currentTheme().textColor
        barChartView.pinchZoomEnabled = true
    }
    
    private func createLineChart() {
        contentView.addSubview(lineChartView)
        lineChartView.setConstraints(topAnchor: barChartView.bottomAnchor, leadingAnchor: contentView.leadingAnchor, bottomAnchor: contentView.bottomAnchor, trailingAnchor: contentView.trailingAnchor, topConstant: 16, leadingConstant: 16, trailingConstant: -16, widthConstant: view.frame.width, heightConstant: view.frame.width)
        
        let incomes = RealmManager.shared.getArray(ofType: Movement.self, filter: "account.id == '\(account.id)' AND type == '\(Movement.MovementType.income.rawValue)'") as! [Movement]
        
        var chartDataEntries: [ChartDataEntry] = []
        for income in incomes {
            chartDataEntries.append(ChartDataEntry(x: income.date.timeIntervalSinceReferenceDate, y: income.amount))
        }
        
        let lineChartDataSet = LineChartDataSet(values: chartDataEntries, label: "Income")
        let lineData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.data = lineData
        
        
    }


}
