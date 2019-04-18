//
//  SwitchTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/11/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate {
    func switchValueChanged(isOn: Bool, tag: Int)
}

class SwitchTableViewCell: UITableViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchValue: UISwitch!
    var delegate: SwitchTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configureWith(theme: Theme) {
        titleLabel.text = "Dark Theme".localized()
        if theme == .light {
            switchValue.isOn = false
        } else {
            switchValue.isOn = true
        }
    }
    
    func configureWith(title: String, value: Bool) {
        titleLabel.text = title
        switchValue.isOn = value
    }

    @IBAction func switchValueChanged(_ sender: UISwitch) {
        delegate?.switchValueChanged(isOn: sender.isOn, tag: tag)
    }
    
}
