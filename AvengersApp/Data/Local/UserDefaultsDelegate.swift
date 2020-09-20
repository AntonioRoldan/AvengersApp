//
//  UserDefaultsDelegate.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 24/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

protocol UserDefaultsDelegate : class {
    func saveScreen(screenName: String)
    func setDidLoadFromBattleController(_ didLoadFromBattleController: Bool)
    func didLoadFromBattleController() -> Bool
    func appHasLaunchedAlready() -> Bool
    func setAppHasLaunchedAlready(appHasLaunched: Bool)
    func getLastScreenWhenClosed() -> String?
}
