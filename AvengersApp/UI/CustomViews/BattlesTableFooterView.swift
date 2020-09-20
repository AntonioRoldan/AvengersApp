//
//  BattlesTableFooterView.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 29/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class BattlesTableFooterView : UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var addNewBattleButton: UIButton!
    
    weak var battlesDelegate: BattlesDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed(BATTLES_TABLE_FOOTER_VIEW, owner: self, options: nil)
        self.addNewBattleButton.layer.cornerRadius = 25
        self.addNewBattleButton.backgroundColor = .white
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func addNewBattleButtonAction(_ sender: Any) {
        self.battlesDelegate?.addNewBattleFromView()
    }
}
