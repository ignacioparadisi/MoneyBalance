//
//  BankTableViewCell.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol AccountsTableViewCellDelegate: class {
    func goToAddAccount()
    func goToDetail(for account: Account)
    func shareAccount(_ text: String)
}

class AccountsTableViewCell: UITableViewCell {

    private let accountsSection = 0
    private let cellIdentifier = "cellIdentifier"
    private let emptyAccountsCellIdentifier = "emptyAccountsCellIdentifier"
    private let sectionInsets: CGFloat = 20.0
    @IBOutlet private weak var collectionView: UICollectionView!
    weak var delegate: AccountsTableViewCellDelegate?
    var accounts: [Account] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        NotificationCenter.default.addObserver(self, selector: #selector(didCreateAccount), name: .didCreateAccount, object: nil)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AccountCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(UINib(nibName: "AddAccountCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: emptyAccountsCellIdentifier)
        fetchAccounts()
    }
    
    private func refresh() {
        fetchAccounts()
        collectionView.reloadData()
    }
    
    @objc private func didCreateAccount() {
        fetchAccounts()
        let newAccountIndexPath = IndexPath(item: accounts.count - 1, section: accountsSection)
        collectionView.reloadData()
        collectionView.scrollToItem(at: newAccountIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func fetchAccounts() {
        if let currentCurrency = Currency.current {
            accounts = RealmManager.shared.getArray(ofType: Account.self, filter: "currency.id == '\(currentCurrency.id)'") as! [Account]
        }
    }
}

extension AccountsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if accounts.isEmpty {
            return 1
        }
        return accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if accounts.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: emptyAccountsCellIdentifier, for: indexPath) as! AddAccountCollectionViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AccountCollectionViewCell
        cell.delegate = self
        cell.configureWith(account: accounts[indexPath.item])
        cell.setGradientBackground(colorOne: ThemeManager.currentTheme().accentColor, colorTwo: ThemeManager.currentTheme().gradientColor, cornerRadius: 10)
        return cell
        

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if accounts.isEmpty {
            delegate?.goToAddAccount()
            return
        }
        let account = accounts[indexPath.item]
        delegate?.goToDetail(for: account)
    }
}

extension AccountsTableViewCell: UICollectionViewDelegateFlowLayout {
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

extension AccountsTableViewCell: AccountCollectionViewCellDelegate {
    func shareAccount(_ text: String) {
        delegate?.shareAccount(text)
    }
}
