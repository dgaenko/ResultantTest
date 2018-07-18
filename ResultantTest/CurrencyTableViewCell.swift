//
//  CurrencyTableViewCell.swift
//  ResultantTest
//
//  Created by Dmytro Gayenko on 18.07.2018.
//  Copyright © 2018 Dmytro Gayenko. All rights reserved.
//

import UIKit

/**
 *  Класс ячейки таблицы данных
 */
class CurrencyTableViewCell: UITableViewCell {
    
    // Аутлеты
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    /**
     *  Метод заполняющий ячейки таблицы данными
     */
    func setRowData(currency: Currency) {
        //print("CurrencyTableViewCell::setRowData " + currency.name)
        nameLabel.text = currency.name
        volumeLabel.text = "\(currency.volume)"
        // вывод с требуемой точностью
        amountLabel.text = String(format: "%.2f", currency.amount)
    }
    
}
