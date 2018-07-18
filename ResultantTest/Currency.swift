//
//  Currency.swift
//  ResultantTest
//
//  Created by Dmytro Gayenko on 18.07.2018.
//  Copyright © 2018 Dmytro Gayenko. All rights reserved.
//

import Foundation

/**
 *  Класс модели данных
 */
class Currency {
    
    var name: String
    var volume: Int
    var amount: Float
 
    init(name: String, volume: Int, amount: Float) {
        self.name = name
        self.volume = volume
        self.amount = amount
    }

}
