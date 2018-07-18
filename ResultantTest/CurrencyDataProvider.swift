//
//  DataProvider.swift
//  ResultantTest
//
//  Created by Dmytro Gayenko on 18.07.2018.
//  Copyright © 2018 Dmytro Gayenko. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

/**
 *  Класс-провайдер данных для таблицы. Загружает данные из внешнего источника, парсит их, уведомляем контроллер главного окна об необходимости обновить данные в таблице
 */
class DataProvider {
 
    let SOURCE_URL_NAME = "sourceUrl"   // имя ключа в конфигурации для внешнего источника данных
    
    var config: NSDictionary?           // копия конфигурации
    var dataArray: [Currency] = []      // массив с данными, получаемый после парсинга внешнего json
    var sourceUrl: String?              // копия URL на внешний JSON-источник данных
    var refresher: RefreshProtocol?     // объект отвечающий за обновление данных в таблице после загрузки
    var isBusy = false                  // флаг занятости провайдера для предотвращения "наложения" обновлений (например? по таймеру и ручного обновления)
    

    init(config: NSDictionary, refresher: RefreshProtocol) {
        self.config = config
        self.refresher = refresher
        
        sourceUrl = self.config!.value(forKey: SOURCE_URL_NAME) as! String
        loadData()
    }
    
    // Геттеры
    
    func getRowsCount() -> Int {
        return dataArray.count
    }
    
    func getData() -> [Currency] {
        return dataArray
    }
    
    
    /**
     *  Метод выполняющий загрузку данных их внешнего источника
     */
    func loadData() {
        
        if (isBusy) {
            return
        }
        
        dataArray.removeAll()
       
        // запрещаем кеширование загружаемых данных
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        Alamofire.SessionManager(configuration: sessionConfig)
        
        isBusy = true
        Alamofire.request(sourceUrl!, method: .get).validate().responseJSON { response in
            switch response.result {
                case .success(let value):
                    print("Remote data loading successefully")
                    
                    // парсинг полученных данных
                    if let jsonData = try? JSON(value) {
                        
                        if let nodes = jsonData["stock"].array {
                            for row in nodes {
                                //print(row["name"].string! + "\n \(row["volume"].int!)")
                                self.dataArray.append(
                                    Currency(name: row["name"].string!, volume: row["volume"].int!, amount: row["price"]["amount"].float!)
                                )
                            }
                            // уведомление контроллера о готовности данных
                            self.refresher!.onDataReloaded()
                        }
                    }
                    self.isBusy = false
                    break
                
                case .failure(let error):
                    print("Remote data loading fail")
                    print(error)
                    self.isBusy = false
                    self.refresher?.onLoadFail()
                    break
            }
        }

    }
    
}
