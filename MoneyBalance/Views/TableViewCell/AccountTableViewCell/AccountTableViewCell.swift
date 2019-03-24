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
    func goToDetail(for account: Account?)
}

class AccountTableViewCell: UITableViewCell {

    private let cellIdentifier = "cellIdentifier"
    private let sectionInsets: CGFloat = 20.0
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: TitleLabel!
    @IBOutlet weak var addAccountButton: UIButton!
    var delegate: AccountTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        titleLabel.text = "Accounts".localized()
        addAccountButton.setImage(UIImage(named: "add")?.withRenderingMode(.alwaysTemplate), for: .normal)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "AccountCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    @IBAction func goToAddAccount(_ sender: Any) {
        delegate?.goToAddAccount()
    }
    
}

extension AccountTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AccountCollectionViewCell
        cell.setGradientBackground(colorOne: ThemeManager.currentTheme().accentColor, colorTwo: ThemeManager.currentTheme().gradientColor)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let item = collectionView.cellForItem(at: indexPath)
//        let selectedFrame = collectionView.convert(item!.frame, to: nil)
//        delegate?.goToDetail(for: nil, frame: selectedFrame)
        delegate?.goToDetail(for: nil)
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
