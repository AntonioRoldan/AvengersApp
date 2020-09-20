//
//  SceneDelegate.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 23/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let dataProvider = DataProvider()
        let heroesViewController = CharactersViewController(options: Options.init(isVillain: false, loadedFromBattle: false))
        let villainsViewController = CharactersViewController(options: Options.init(isVillain: true, loadedFromBattle: false))
        let battlesViewController = BattlesViewController()
        heroesViewController.title = "Heroes"
        villainsViewController.title = "Villains"
        battlesViewController.title = "Battles"
        let navigationHeroesController = UINavigationController.init(rootViewController: heroesViewController)
        let navigationVillainsController = UINavigationController.init(rootViewController: villainsViewController)
        let navigationBattlesController = UINavigationController.init(rootViewController: battlesViewController)
        
        navigationHeroesController.tabBarItem = UITabBarItem.init(title: "Heroes", image: UIImage.init(named: "ic_tab_heroes"), tag: 0)
        navigationVillainsController.tabBarItem = UITabBarItem.init(title: "Villains", image: UIImage.init(named: "ic_tab_villain"), tag: 1)
        navigationBattlesController.tabBarItem = UITabBarItem.init(title: "Battles", image: UIImage.init(named: "ic_tab_battles"), tag: 2)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationHeroesController, navigationBattlesController, navigationVillainsController]
        tabBarController.tabBar.barStyle = .default
        tabBarController.tabBar.isTranslucent = true
        tabBarController.tabBar.tintColor = UIColor.blue
        tabBarController.delegate = battlesViewController
        UINavigationBar.appearance().overrideUserInterfaceStyle = .dark
        UINavigationBar.appearance().tintColor = UIColor.blue
        
        if(!dataProvider.appHasLaunchedAlready()){
            setUpDatabaseData(dataProvider: dataProvider)
            dataProvider.setAppHasLaunchedAlready(appHasLaunched: true)
        }
        
        if(dataProvider.didLoadFromBattleController()){
            dataProvider.deleteIncompleteBattles()
            dataProvider.setDidLoadFromBattleController(didLoadFromBattleController: false)
            dataProvider.saveScreen(screenName: BATTLES_SCREEN)
        }
        
        switch dataProvider.getLastScreenWhenClosed() {
            case HEROES_SCREEN:
                tabBarController.selectedIndex = 0
            case VILLAINS_SCREEN:
                tabBarController.selectedIndex = 2
            default:
                tabBarController.selectedIndex = 1
        }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

