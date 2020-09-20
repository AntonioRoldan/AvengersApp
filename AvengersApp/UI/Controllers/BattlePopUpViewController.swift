//
//  BattlePopUpViewController.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 29/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class BattlePopUpViewController : UIViewController {
    
    @IBOutlet weak var popUpView: UIView!
    
    var battleToBeDeleted: Battle? = nil
    
    weak var battlesDelegate: BattlesDelegate? = nil
    
    let dataProvider : DataProvider = DataProvider()
    
   
    init() {
        super.init(nibName: "BattlePopUp", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.configureViews()
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteBattle(_ sender: Any) {
        guard let battle = self.battleToBeDeleted else { return }
        dataProvider.deleteBattle(battle: battle)
        self.battlesDelegate?.battleWasDeleted()
        self.dismiss(animated: true, completion: nil)
    }
    
    func configure(battleToBeDeleted: Battle){
        self.battleToBeDeleted = battleToBeDeleted
    }
    
    private func configureViews() {
        // Add corner radius for the "pop up" view
        self.popUpView.layer.cornerRadius = 8.0
        configureViewEffects()
    }
    
    // Add a blur effect to the background view
    private func configureViewEffects() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.view.bounds
        self.view.addSubview(blurredEffectView)
        self.view.sendSubviewToBack(blurredEffectView)
    }

}
