//
//  BattleCollectionViewCellModel.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 01/05/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

struct BattleCollectionViewCellModel  {

    let battleName: String
    let winnerIsHero: Bool
    let loadedFromHeroes: Bool
    
    init(battleName: String, isHero: Bool, loadedFromHeroes: Bool) {
        self.battleName = battleName
        self.winnerIsHero = isHero
        self.loadedFromHeroes = loadedFromHeroes
    }
}
