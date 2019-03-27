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

    @IBOutlet weak var barView: BarChartView!
    var account: Account = Account()
    
    override func setupView() {
        super.setupView()
        updateChartWithData()
    }
    
    private func updateChartWithData() {
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
        barView.data = chartData
        barView.xAxis.labelTextColor = ThemeManager.currentTheme().textColor
        barView.getAxis(.left).labelTextColor = ThemeManager.currentTheme().textColor
        barView.getAxis(.right).labelTextColor = ThemeManager.currentTheme().textColor
        barView.legend.textColor = ThemeManager.currentTheme().textColor
        barView.pinchZoomEnabled = true
    }


}
