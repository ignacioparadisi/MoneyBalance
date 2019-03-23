//
//  CurrenciesViewController.swift
//  MoneyBalance
//
//  Created by Ignacio Paradisi on 3/12/19.
//  Copyright © 2019 Ignacio Paradisi. All rights reserved.
//

import UIKit

protocol CurrenciesViewControllerDelegate {
    func selectedCurrencyChanged()
}

class CurrenciesViewController: BaseViewController {

    private let sectionInsets: CGFloat = 10
    private var currencies: [Currency] = []
    var delegate: CurrenciesViewControllerDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "Currencies".localized()
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCurrency))
        addButton.tintColor = ThemeManager.currentTheme().accentColor
        navigationItem.setRightBarButton(addButton, animated: false)
        let hideButton = UIBarButtonItem(title: "Hide".localized(), style: .done, target: self, action: #selector(dismissPanel))
        navigationItem.setLeftBarButton(hideButton, animated: false)
    }
    
    override func setupView() {
        super.setupView()
        view.backgroundColor = ThemeManager.currentTheme().bottomSheetColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: "CurrencyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        fetchData()
    }
    
    private func fetchData() {
        currencies = RealmManager.shared.getArray(ofType: Currency.self, filter: "owned == true") as! [Currency]
        currencies.sort { (currency1, currency2) -> Bool in
            return currency1.name < currency2.name
        }
        collectionView.reloadData()
    }
    
    @objc private func addCurrency() {
        let controller = AddNewCurrencyViewController()
        presentAsStork(UINavigationController(rootViewController: controller))
    }
    
}

extension CurrenciesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CurrencyCollectionViewCell
        cell.delegate = self
        cell.tag = indexPath.item
        cell.configuereWith(currency: currencies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let currency = currencies[index]
        RealmManager.shared.changeCurrency(currency)
        Currency.setCurrent(currency)
        delegate?.selectedCurrencyChanged()
        fetchData()
    }
}

extension CurrenciesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 - (sectionInsets * 2), height: 55)
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

extension CurrenciesViewController: AddNewCurrencyViewControllerDelegate {
    func selectedCurrencyChanged() {
        fetchData()
    }
}

extension CurrenciesViewController: CurrencyCollectionViewCellDelegate {
    func deleteCurrency(at index: Int) {
        let alert = UIAlertController(title: "Delete".localized(), message: "Delete currency".localized(), preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete".localized(), style: .destructive, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
    }
    
}
