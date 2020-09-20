//
//  Database.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 24/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import Foundation

class DataProvider {
    let userDefaultsDelegate : UserDefaultsDelegate = UserDefaultsDatabase()
    let coreDataDelegate : CoreDataDelegate = CoreDatabase()
    
    func createHeroe() -> Hero? {
        guard let heroe = coreDataDelegate.createDataHeroe() else { return nil }
        return heroe
    }
    
    func createVillain() -> Villain? {
        guard let villain = coreDataDelegate.createDataVillain() else { return nil }
        return villain
    }
    
    func createBattle() -> Battle? {
        guard let battle = coreDataDelegate.createDataBattle() else { return nil }
        return battle
    }
    
    func saveHeroe(heroe: Hero) {
        coreDataDelegate.persistHeroe(heroe: heroe)
    }
    
    func saveVillain(villain: Villain) {
        coreDataDelegate.persistVillain(villain: villain)
    }
    
    func saveBattle(battle: Battle) {
        coreDataDelegate.persistBattle(battle: battle)
    }
    
    func loadHeroes() -> [Hero] {
        guard let data = coreDataDelegate.fetchHeroes() else {
            return []
        }
        return data
    }
    
    func loadVillains() -> [Villain] {
        guard let data = coreDataDelegate.fetchVillains() else {
            return []
        }
        return data
    }
    
    func loadBattles() -> [Battle] {
        guard let data = coreDataDelegate.fetchBattles() else {
            return []
        }
        return data
    }
    
    func deleteBattle(battle: Battle) {
        coreDataDelegate.deleteBattle(battle: battle)
    }
    
    func setDidLoadFromBattleController(didLoadFromBattleController: Bool){
        userDefaultsDelegate.setDidLoadFromBattleController(didLoadFromBattleController)
    }
    
    func didLoadFromBattleController() -> Bool {
        return userDefaultsDelegate.didLoadFromBattleController()
    }
    
    func saveScreen(screenName: String){
        userDefaultsDelegate.saveScreen(screenName: screenName)
    }
    
    func appHasLaunchedAlready() -> Bool {
        return userDefaultsDelegate.appHasLaunchedAlready()
    }
    
    func setAppHasLaunchedAlready(appHasLaunched: Bool){
        userDefaultsDelegate.setAppHasLaunchedAlready(appHasLaunched: appHasLaunched)
    }
    
    func deleteIncompleteBattles() {
        return coreDataDelegate.deleteIncompleteBattles()
    }
    
    func getLastScreenWhenClosed() -> String? {
        return userDefaultsDelegate.getLastScreenWhenClosed()
    }
    
    func editHerosPower(power: Int, name:String){
        coreDataDelegate.editHerosPower(power: power, name: name)
    }
    
    func editVillainsPower(power:  Int, name: String){
        coreDataDelegate.editHerosPower(power: power, name: name)
    }
}
