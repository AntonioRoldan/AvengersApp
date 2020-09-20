//
//  CharacterDetailViewController.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 28/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class CharacterDetailViewController : UIViewController {
    
    let dataProvider : DataProvider = DataProvider()
    
    let characterName : String
      
    let isHero : Bool
    
    var image : String = ""
    
    var power : Int = 0
    
    var hero : Hero? = nil
    
    var villain: Villain? = nil
    
    var battles : [Battle] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var characterPower: UIImageView!
    
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
        
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBAction func editPower(_ sender: Any) {
        let editPowerViewController = EditPowerViewController()
        editPowerViewController.isHero = self.isHero
        editPowerViewController.characterName = self.characterName
        editPowerViewController.characterDetailDelegate = self
        self.present(editPowerViewController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var powerImage: UIImageView!
    
    init(characterName: String, isHero: Bool) {
        self.characterName = characterName
        self.isHero = isHero
        super.init(nibName: "CharacterDetail", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.configureView()
    }
    
    //MARK: Private methods
    
    private func configureView(){
        self.characterImage.image = UIImage(named: self.image)
        self.setPowerStars()
        self.configureCollectionView()
    }
    
    private func setPowerStars(){
        switch self.power {
            case 1:
                self.powerImage.image = UIImage(named: STARS_ONE)
                break
            case 2:
                self.powerImage.image = UIImage(named: STARS_TWO)
                break
            case 3:
                self.powerImage.image = UIImage(named: STARS_THREE)
                break
            case 4:
                self.powerImage.image = UIImage(named: STARS_FOUR)
                break
            case 5:
                self.powerImage.image = UIImage(named: STARS_FIVE)
                break
            default:
                self.powerImage.image = UIImage(named: STARS_ZERO)
            }
    }
}

extension CharacterDetailViewController : UICollectionViewDataSource {
    
    func configureCollectionView(){
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = self.view.backgroundColor
        let nib = UINib.init(nibName: BATTLE_COLLECTION_VIEW_CELL, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: BATTLE_COLLECTION_VIEW_CELL)
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.battles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: BATTLE_COLLECTION_VIEW_CELL, for: indexPath) as? BattleCollectionViewCell, let name = self.battles[indexPath.row].name  else { return UICollectionViewCell() }
        let battle = self.battles[indexPath.row]
        cell.configure(viewModel: BattleCollectionViewCellModel.init(battleName: name, isHero: battle.winnerIsHero, loadedFromHeroes: self.isHero))
        return cell
    }
}

extension CharacterDetailViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 300, height: 40)
    }
}

protocol CharacterDetailDelegate : class {
    func editCharacterPower(power: Int)
}

extension CharacterDetailViewController : CharacterDetailDelegate {
    func editCharacterPower(power: Int) {
        if(self.isHero){
            guard let hero = self.hero else { return }
            hero.power = Int16(power)
            dataProvider.saveHeroe(heroe: hero)
        } else {
            guard let villain = self.villain else { return }
            villain.power = Int16(power)
            dataProvider.saveVillain(villain: villain)
        }
        self.power = power
        self.setPowerStars()
    }
}
