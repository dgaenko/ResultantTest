//
//  RefreshProtocol.swift
//  ResultantTest
//
//  Created by Dmytro Gayenko on 18.07.2018.
//  Copyright © 2018 Dmytro Gayenko. All rights reserved.
//

import Foundation

/**
 *  Протокол для реализации уведомления коньтроллера о необходимости обновления таблицы
 */
protocol RefreshProtocol {
    
    func onDataReloaded()
    func onLoadFail()
    
}
