//
//  BattlesViewController.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 23/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class BattlesViewController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyBattlesLabel: UILabel!
    
    @IBOutlet weak var addBattleButton: UIButton!
    
    let dataProvider = DataProvider()

    var battles : [Battle] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBattleButton.layer.cornerRadius = 25
        self.manageScreenStates()
        self.configureTable()
        self.retrieveData()
    }
    
    init() {
        super.init(nibName: "Battles", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func addBattleButtonPressed(_ sender: Any) {
        self.addNewBattle()
    }
    
    func addNewBattle(){
        guard let battle = dataProvider.createBattle() else { return }
        battle.id = UUID()
        let options = Options.init(isVillain: false, loadedFromBattle: true)
        let heroesViewController = CharactersViewController(options: options)
        heroesViewController.battlesDelegate = self
        heroesViewController.battle = battle //Asignamos la nueva batalla que vamos a añadir
        heroesViewController.isModalInPresentation = true
        self.present(heroesViewController, animated: true, completion: nil)
    }
    
    private func manageScreenStates(){
        dataProvider.saveScreen(screenName: BATTLES_SCREEN)
    }
    
    private func retrieveData(){
        self.battles = dataProvider.loadBattles()
        self.updateUI()
    }
    
    private func updateUI(){
        /*
         Updates the UI depending on whether the battles array is empty or not
         */
        if(self.battles.isEmpty){
            self.setEmptyArrayScreen()
        } else {
            self.setTableViewScreen()
        }
    }
    
    private func setEmptyArrayScreen(){
        self.tableView.isHidden = true
        self.emptyBattlesLabel.isHidden = false
        self.addBattleButton.isHidden = false
    }
    
    private func setTableViewScreen(){
        self.tableView.isHidden = false
        self.emptyBattlesLabel.isHidden = true
        self.addBattleButton.isHidden = true
    }
}

//MARK: Table view data source methods

extension BattlesViewController : UITableViewDataSource {
    
    //MARK: Table configuration method
    private func configureTable(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let cellNib = UINib.init(nibName: BATTLE_CELL, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: BATTLE_CELL)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.battles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let heroImage = self.battles[indexPath.row].hero?.image, let villainImage = self.battles[indexPath.row].villain?.image, let cell = self.tableView.dequeueReusableCell(withIdentifier: BATTLE_CELL, for: indexPath) as? BattleCell else { return UITableViewCell() }
            if(self.battles[indexPath.row].winnerIsHero){
                cell.configure(winnerImage: heroImage, loserImage: villainImage)
            } else {
                cell.configure(winnerImage: villainImage, loserImage: heroImage)
            }
        return cell
    }
}

//MARK: Table view delegate methods

extension BattlesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = BattlesTableFooterView()
        
        view.battlesDelegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let popUpWindow = BattlePopUpViewController()
        popUpWindow.configure(battleToBeDeleted: self.battles[indexPath.row])
        popUpWindow.battlesDelegate = self
        self.present(popUpWindow, animated: true, completion: nil)
    }
    
}

extension BattlesViewController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch viewController.title {
        case "Battles":
            if(!dataProvider.didLoadFromBattleController()){
                dataProvider.saveScreen(screenName: BATTLES_SCREEN)
            }
        case "Heroes":
            dataProvider.saveScreen(screenName: HEROES_SCREEN)
        default:
            dataProvider.saveScreen(screenName: VILLAINS_SCREEN)
        }
    }
}

extension BattlesViewController : BattlesDelegate {
    
    func battleWasAdded() {
        self.retrieveData()
    }
    func battleWasDeleted() {
        self.retrieveData()
    }
    func addNewBattleFromView(){
        self.addNewBattle()
    }
}

protocol BattlesDelegate : class {
    func battleWasAdded()
    func battleWasDeleted()
    func addNewBattleFromView()
}


