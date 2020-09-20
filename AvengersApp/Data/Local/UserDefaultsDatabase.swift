//
//  UserDefaultsDatabase.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 24/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import Foundation

class UserDefaultsDatabase : UserDefaultsDelegate {
   
    func saveScreen(screenName: String) {
        UserDefaults.standard.set(screenName, forKey: LAST_SCREEN_LOADED)
    }
    
    func getLastScreenWhenClosed() -> String? {
        guard let lastScreen = UserDefaults.standard.string(forKey: LAST_SCREEN_LOADED) else { return nil}
        return lastScreen
    }
    
    func setDidLoadFromBattleController(_ didLoadFromBattleController: Bool){
        UserDefaults.standard.set(didLoadFromBattleController, forKey: DID_LOAD_FROM_BATTLE_CONTROLLER)
    }
    
    func didLoadFromBattleController() -> Bool {
        return UserDefaults.standard.bool(forKey: DID_LOAD_FROM_BATTLE_CONTROLLER)
    }
    
    func setAppHasLaunchedAlready(appHasLaunched: Bool) {
        UserDefaults.standard.set(appHasLaunched, forKey: APP_HAS_ALREADY_LAUNCHED)
    }
    
    func appHasLaunchedAlready() -> Bool {
        return UserDefaults.standard.bool(forKey: APP_HAS_ALREADY_LAUNCHED)
    }
}

