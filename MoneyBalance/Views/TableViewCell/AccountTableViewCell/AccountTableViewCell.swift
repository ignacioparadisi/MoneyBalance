//
//  BankTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol AccountTableViewCellDelegate {
    func goToAddAccount()
//    func goToDetail(for account: Account?, frame: CGRect)
    func goToDetail(for account: Account)
    func shareAccount(_ text: String)
}

class AccountTableViewCell: UITableViewCell {

    private let cellIdentifier = "cellIdentifier"
    private let emptyAccountsCellIdentifier = "emptyAccountsCellIdentifier"
    private let sectionInsets: CGFloat = 20.0
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: TitleLabel!
    @IBOutlet weak var addAccountButton: UIButton!
    var delegate: AccountTableViewCellDelegate?
    var accounts: [Account] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        NotificationCenter.default.addObserver(self, selector: #selector(fetchAccounts), name: .didCreateAccount, object: nil)
        titleLabel.text = "Accounts".localized()
        addAccountButton.setImage(UIImage(named: "add")?.withRenderingMode(.alwaysTemplate), for: .normal)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AccountCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(UINib(nibName: "AddAccountCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: emptyAccountsCellIdentifier)
        fetchAccounts()
    }
    
    @objc private func fetchAccounts() {
        if let currentCurrency = Currency.current {
            accounts = RealmManager.shared.getArray(ofType: Account.self, filter: "currency.id == '\(currentCurrency.id)'") as! [Account]
        }
        collectionView.reloadData()
    }
    
    @IBAction func goToAddAccount(_ sender: Any) {
        delegate?.goToAddAccount()
    }
    
}

extension AccountTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if accounts.count == 0 {
            return 1
        }
        return accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if accounts.count == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyAccountsCellIdentifier, for: indexPath) as! AddAccountCollectionViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AccountCollectionViewCell
        cell.delegate = self
        cell.configureWith(account: accounts[indexPath.item])
        cell.setGradientBackground(colorOne: ThemeManager.currentTheme().accentColor, colorTwo: ThemeManager.currentTheme().gradientColor)
        return cell
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if accounts.count == 0 {
            delegate?.goToAddAccount()
            return
        }
        let account = accounts[indexPath.item]
        delegate?.goToDetail(for: account)
    }
}

extension AccountTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - (sectionInsets * 2), height: collectionView.frame.height - (sectionInsets * 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: sectionInsets, left: sectionInsets, bottom: sectionInsets, right: sectionInsets)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets * 2
    }
}

extension AccountTableViewCell: AccountCollectionViewCellDelegate {
    func shareAccount(_ text: String) {
        delegate?.shareAccount(text)
    }
}
