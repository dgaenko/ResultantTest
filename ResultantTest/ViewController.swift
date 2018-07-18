//
//  ViewController.swift
//  ResultantTest
//
//  Created by Dmytro Gayenko on 18.07.2018.
//  Copyright © 2018 Dmytro Gayenko. All rights reserved.
//

import UIKit


/**
 *  Контроллер главного окна приложения
 */
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RefreshProtocol {

    let TABLE_ROW_HEIGHT = 50.0                         // Константа, задающая высоту строки таблицы
    let RELOAD_INTERVAL = 15.0                          // Интервал таймера для периодической загрузки

    var timer: Timer?                                   // Таймер для периодического обновления
    var dataProvider: DataProvider?                     // Провайдер данных для таблицы

    @IBOutlet weak var currenciesTable: UITableView!    // Аутлет таблицы с данными
    
    /**
     *  Обработчик кнопки принудательной загрузки данных из внешнего JSON файла
     */
    @IBAction func reloadButtonHandler(_ sender: Any) {
        self.view.showToast(message: "Start manual reload", bgcolor: UIColor.blue)
        dataProvider?.loadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currenciesTable.delegate = self
        currenciesTable.dataSource = self
        currenciesTable.rowHeight = CGFloat(TABLE_ROW_HEIGHT)   // установка высоты строки таблицы

        // получаем из делегата приложения конфигурационные данные для загрузки внешнего JSON
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataProvider = DataProvider(config: appDelegate.config!, refresher: self)
        
        // установка таймера для периодических обновлений
        timer = Timer.scheduledTimer(timeInterval: RELOAD_INTERVAL, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    /**
     *  Вызывается из DataProvider по успешному завершению загрузки и обратотки данных из внешнего JSON файла для обновления данных в UITableView
     */
    func onDataReloaded() {
        print("onDataReloaded")
        DispatchQueue.main.async{
            self.currenciesTable.reloadData()
        }
    }

    /**
     *  Вызывается из DataProvider при возникновении ошибки загрузки данных из внешнего JSON файла
     */
    func onLoadFail() {
        print("onLoadFail")
        self.view.showToast(message: "Data loading fail!", bgcolor: UIColor.red)
    }
    
    /**
     *  Метод для таймера загрузки данных из внешнего JSON файла
     */
    @objc func update() {
        print("update")
        self.view.showToast(message: "Start update by timer", bgcolor: UIColor.green)
        dataProvider?.loadData()
    }

    // MARK: - TableView methods.

    /**
     *  Метод возвращающий кол-во данных в источнике данных
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("tableView::numberOfRowsInSection")
        return dataProvider!.getData().count
    }
    
    /**
     *  Метод возвращающий возвращающий инстанс ячейки таблицы
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("tableView::cellForRowAt IndexPath: \(indexPath.row)")

        let currency = dataProvider!.getData()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyTableCell") as! CurrencyTableViewCell
        // заполняем UI-элементы ячейки данными
        cell.setRowData(currency: currency)
        
        return cell
    }
    
}

