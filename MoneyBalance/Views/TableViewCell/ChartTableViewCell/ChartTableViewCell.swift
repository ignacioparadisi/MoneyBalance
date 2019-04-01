//
//  ChartTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/30/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit
import Charts

class ChartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chart: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        chart.backgroundColor = .clear
    }
    
    func configureWith(accounts: [Account]) {
        var entries: [PieChartDataEntry] = []
        for account in accounts where account.money >= 0 {
            let entry = PieChartDataEntry(value: account.money, label: account.bankName)
            entries.append(entry)
        }
        
        let dataSet = PieChartDataSet(values: entries, label: "Savings".localized())
        dataSet.colors = [UIColor("FD2D55"), UIColor("007AFF"), UIColor("#52C6A7"), UIColor("FD582F"), .red, .blue, .orange, .purple]
        let data = PieChartData(dataSet: dataSet)
        chart.data = data
        
        setupChartStyle()
    }
    
    func setupChartStyle() {
        chart.holeColor = ThemeManager.currentTheme().backgroundColor
        chart.usePercentValuesEnabled = true
        chart.legend.textColor = ThemeManager.currentTheme().textColor
        chart.legend.textWidthMax = 17.0
        chart.entryLabelColor = .red
    }
}
