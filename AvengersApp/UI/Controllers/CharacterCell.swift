//
//  CharactersCell.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 24/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class CharacterCell : UITableViewCell {
    
    //MARK: Outlets
    
    
    @IBOutlet weak var charaterImage: UIImageView!
    
    @IBOutlet weak var powerImage: UIImageView!
    
    @IBOutlet weak var CharacterName: UILabel!
    
    //MARK: Actions
    
    //MARK: Private properties
    
    var hero: Hero?
    
    var villain: Villain?
    
    //MARK: Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
// 
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        //set the values for top,left,bottom,right margins
//        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
//        contentView.frame = contentView.frame.inset(by: margins)
//    }
    
    override func prepareForReuse() {
        self.hero = nil
        self.villain = nil
        update(characterName: nil)
        update(characterImage: nil)
        update(powerImage: nil)
    }
    
    //MARK: Configure view methods
    
    func configure(withCharacter: Character){
        if let hero = withCharacter.hero, let image = hero.image, let name = hero.name {
            self.contentView.backgroundColor = UIColor(red: 0.75, green: 0.83, blue: 0.95, alpha: 1.00)
            self.hero = hero
            update(characterName: name)
            update(characterImage: image)
            update(powerImage: Int(hero.power))
        }
        else if let villain = withCharacter.villain, let image = villain.image, let name = villain.name {
            self.contentView.backgroundColor =  UIColor(red: 0.98, green: 0.82, blue: 0.76, alpha: 1.00)
            self.villain = villain
            update(characterName: name)
            update(characterImage: image)
            update(powerImage: Int(villain.power))
        }
    }
    
    //MARK: Private methods
    
    private func update(characterImage: String?){
        if let characterImage = characterImage {
            self.charaterImage.image = UIImage.init(named: characterImage)
            return
        }
        self.charaterImage.image = nil
    }
    
    private func update(characterName: String?){
        self.CharacterName.text = characterName
    }
    
    private func update(powerImage: Int?){
        switch powerImage {
        case 1:
            self.powerImage.image = UIImage.init(named: STARS_ONE)
        case 2:
            self.powerImage.image = UIImage.init(named: STARS_TWO)
        case 3:
            self.powerImage.image = UIImage.init(named: STARS_THREE)
        case 4:
            self.powerImage.image = UIImage.init(named: STARS_FOUR)
        case 5:
            self.powerImage.image = UIImage.init(named: STARS_FIVE)
        default:
            self.powerImage.image = UIImage.init(named: STARS_ZERO)
        }
    }
}
