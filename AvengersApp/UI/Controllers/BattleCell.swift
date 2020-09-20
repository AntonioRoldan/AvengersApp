//
//  BattleCell.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 28/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class BattleCell : UITableViewCell {
    @IBOutlet weak var winnerImage: UIImageView!
    
    @IBOutlet weak var loserImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
        
    }
    //MARK: Cell configuration
    
    private func setUpUI(){
        self.winnerImage.layer.cornerRadius = 8
        self.loserImage.layer.cornerRadius = 8
        self.winnerImage.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.70, alpha: 1.0).cgColor
            self.loserImage.layer.borderColor = UIColor(red: 0.70, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
        self.winnerImage.layer.borderWidth = 2.0
        self.loserImage.layer.borderWidth = 2.0
    }
    
    func configure(winnerImage: String, loserImage: String){
        self.winnerImage.image = UIImage.init(named: winnerImage)
        self.loserImage.image = UIImage.init(named: loserImage)
    }
}

