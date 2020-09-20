//
//  CoreDataDelegate.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 23/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataDelegate : class {
    var context: NSManagedObjectContext? {get}
    
    func createDataHeroe() -> Hero?
    
    func createDataVillain() -> Villain?
    
    func createDataBattle() -> Battle?
    
    func persistHeroe(heroe: Hero)
    
    func persistVillain(villain: Villain)
    
    func persistBattle(battle: Battle)
    
    func fetchHeroes() -> [Hero]?
    
    func fetchVillains() -> [Villain]?
    
    func fetchBattles() -> [Battle]?
    
    func deleteBattle(battle: Battle)
    
    func deleteIncompleteBattles()
    
    func editHerosPower(power: Int, name: String)
    
    func editVillainsPower(power: Int, name: String)
    
}
