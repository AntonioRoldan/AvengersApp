//
//  ViewController.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 23/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class CharactersViewController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let options : Options
        
    let dataProvider : DataProvider = DataProvider()
    
    var battle: Battle? = nil
    
    weak var battlesDelegate : BattlesDelegate? = nil
    
    var villains: [Villain] = [] {
        didSet {
            tableView.reloadData()
        }
    } //Si utilizamos este view controller para villanos rellenaremos este array
    
    var heroes: [Hero] = [] {
        didSet {
            tableView.reloadData()
        }
    } //Si utilizamos este view controller para heroes rellenaremos este array
    
    init(options: Options) {
        self.options = options
        super.init(nibName: "Characters", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNotifications()
        self.view.backgroundColor = self.options.isVillain ? UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00) : UIColor(red: 0.75, green: 0.83, blue: 0.95, alpha: 1.00)
//        self.tabBarController?.delegate = self
        self.saveScreenState()
        self.configureTableView()
        self.retrieveData()
        
        // Do any additional setup after loading the view.
    }
    
    deinit {
        let powerEdited = Notification.Name.init(rawValue: CHARACTERS_TABLE_RELOAD_NOTIFICATION)
        NotificationCenter.default.removeObserver(self, name: powerEdited, object: nil)
    }
    
    private func setUpNotifications(){
        let powerEdited = Notification.Name.init(rawValue: CHARACTERS_TABLE_RELOAD_NOTIFICATION)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableOnPowerEdited), name: powerEdited, object: nil)
    }
    
    @objc private func reloadTableOnPowerEdited(){
        self.tableView.reloadData()
    }
    
    private func createCharacter(indexPath: IndexPath) -> Character{
        return self.options.isVillain ? Character.init(hero: nil, villain: self.villains[indexPath.row]) : Character.init(hero: self.heroes[indexPath.row], villain: nil)
    }
    
    private func determineBattleWinner(){
        self.setBattleName()
        guard let heroWonBattle = self.heroWonBattle() else { return }
        if(heroWonBattle){
            self.battle?.winner = self.battle?.hero?.name
            self.battle?.winnerIsHero = true //Utilizaremos este booleano para determinar el color de la batalla cuando aparezca en la vista de detalle
            return
        }
        self.battle?.winner = self.battle?.villain?.name
        self.battle?.winnerIsHero = false
    }
    
    private func setBattleName(){
        guard let heroName = self.battle?.hero?.name, let villainName = self.battle?.villain?.name else { return }
        self.battle?.name = "\(heroName) vs \(villainName)"
    }
    
    private func heroWonBattle() -> Bool? {
        //Returns true if hero wins, false for villain
        guard let hero = self.battle?.hero, let villain = self.battle?.villain else { return nil }
        var heroResult = 0
        var villainResult = 0
        while(heroResult == villainResult){
            //Lo repetimos en caso de que dieran los mismo resultados para hero y villain
            let randomHeroNumber = Int.random(in: 1...5)
            let randomVillainNumber = Int.random(in: 1...5)
            heroResult = Int(hero.power) + randomHeroNumber
            villainResult = Int(villain.power) + randomVillainNumber
        }
        return heroResult >= villainResult
    }
    
    private func saveScreenState(){
        if(self.options.loadedFromBattle){
            dataProvider.setDidLoadFromBattleController(didLoadFromBattleController: true)
        }
        if(self.options.isVillain && !self.options.loadedFromBattle){
            dataProvider.saveScreen(screenName: VILLAINS_SCREEN)
        } else if(!self.options.loadedFromBattle){
            dataProvider.saveScreen(screenName: HEROES_SCREEN)
        }
    }
    
    private func retrieveData(){
        if(self.options.isVillain){
            self.villains = dataProvider.loadVillains()
        } else {
            self.heroes = dataProvider.loadHeroes()
        }
    }
    
    private func getImage(indexPath: IndexPath) -> String? {
        if(self.options.isVillain){
            guard let image = self.villains[indexPath.row].image else { return nil }
            return image
        }
        guard let image = self.heroes[indexPath.row].image else { return nil}
        return image
    }
    
    private func getBattles(indexPath: IndexPath) -> [Battle]? {
        if(self.options.isVillain){
            guard let battles = self.villains[indexPath.row].battles?.allObjects as? [Battle] else { return nil }
            return battles
        }
        guard let battles = self.heroes[indexPath.row].battles?.allObjects as? [Battle] else { return nil }
        return battles
    }
    
    private func setDestinationViewController(isHero: Bool, indexPath: IndexPath){
        let characterName = self.options.isVillain ? self.villains[indexPath.row].name : self.heroes[indexPath.row].name
        guard let name = characterName, let image = self.getImage(indexPath: indexPath), let battles = self.getBattles(indexPath: indexPath)  else { return }
        let characterDetailViewController = CharacterDetailViewController.init(characterName: name, isHero: isHero)
        if(isHero){
            characterDetailViewController.hero = self.heroes[indexPath.row]
        } else {
            characterDetailViewController.villain = self.villains[indexPath.row]
        }
        characterDetailViewController.battles = battles
        characterDetailViewController.image = image
        characterDetailViewController.power = self.options.isVillain ? Int(self.villains[indexPath.row].power) : Int(self.heroes[indexPath.row].power)
        self.navigationController?.pushViewController(characterDetailViewController, animated: true)
    }
}

//extension CharactersViewController : UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        let screenName = self.options.isVillain ? VILLAINS_SCREEN : HEROES_SCREEN
//        print(screenName)
//        dataProvider.saveScreen(screenName: screenName)
//    }
//}

extension CharactersViewController : UITableViewDataSource {
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        let characterNib = UINib.init(nibName: CHARACTER_CELL, bundle: nil)
        tableView.register(characterNib, forCellReuseIdentifier: CHARACTER_CELL)
        tableView.tableFooterView = UIView()
        
//        tableView.estimatedRowHeight = tableView.rowHeight
//        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.options.isVillain){
            return self.villains.count
        } else {
            return self.heroes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CHARACTER_CELL, for: indexPath) as? CharacterCell {
            let character = self.createCharacter(indexPath: indexPath)
            cell.configure(withCharacter: character)
            return cell
        }
        fatalError()
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Characters"
//    }
}

extension CharactersViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.options.loadedFromBattle){ //Si cargamos el view controller desde battles, reutilizamos este view controller como una pantalla de selección
            if(self.options.isVillain){
                //Mostramos la pantalla de selección de villano después de haber mostrado la de selección de héroe así que refrescamos la tabla desde aquí y volvemos a battles
                guard let battle = self.battle else { return } //TODO: Comprobar que se almacena correctamente 
                battle.villain = self.villains[indexPath.row]
            
                dataProvider.setDidLoadFromBattleController(didLoadFromBattleController: false) //Como ha hemosañadido los atributos, cambiamos seteamos el didLoadFromBattle a false
                self.determineBattleWinner()
                dataProvider.saveBattle(battle: battle) //Y guardamos la batalla
                dataProvider.saveScreen(screenName: BATTLES_SCREEN)
                self.battlesDelegate?.battleWasAdded() //Despues refrescamos la tabla de battles
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            } else {//Si no es la pantalla de villanos y cargamos desde battles entonces es la de selección de héroes
                self.battle?.hero = heroes[indexPath.row]
                let optionsVillain = Options.init(isVillain: true, loadedFromBattle: true)
                let villainsViewController = CharactersViewController(options: optionsVillain)
                villainsViewController.battlesDelegate = self.battlesDelegate
                villainsViewController.isModalInPresentation = true
                villainsViewController.battle = self.battle
                self.present(villainsViewController, animated: true, completion: nil)
            }
        }
        self.setDestinationViewController(isHero: !self.options.isVillain, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

protocol CharactersDelegate : class {
    func dataChanged()
}

