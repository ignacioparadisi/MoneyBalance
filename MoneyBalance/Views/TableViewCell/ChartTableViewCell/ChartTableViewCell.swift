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
        for account in accounts {
            let entry = PieChartDataEntry(value: account.money, label: account.bankName)
            entries.append(entry)
        }
        
        let dataSet = PieChartDataSet(values: entries, label: "Savings".localized())
        let data = PieChartData(dataSet: dataSet)
        chart.data = data
    }
}
