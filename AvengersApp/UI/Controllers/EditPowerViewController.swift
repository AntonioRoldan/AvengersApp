//
//  EditPowerViewController.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 30/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit

class EditPowerViewController : UIViewController {
    
    let dataProvider = DataProvider()
    
    var isHero = false
    
    var characterName = ""
    
    weak var characterDetailDelegate : CharacterDetailDelegate? = nil 
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var editPowerTextField: UITextField!
    
    @IBOutlet weak var editPowerButton: UIButton!
    
    
    @IBAction func editPowerButtonPressed(_ sender: Any) {
        //Nos aseguramos de que el input es un número entre el 1 y el 5
        guard let editPowerInput = editPowerTextField.text else { return }
        if(Validation.shared.validateEditPower(editPowerInput: editPowerInput)){
            guard let editPowerInt = Int(editPowerInput) else { return }
            if(self.isHero){
                characterDetailDelegate?.editCharacterPower(power: editPowerInt)
                self.postCharactersNotification()
                self.dismiss(animated: true, completion: nil)
                return
            } else {
                characterDetailDelegate?.editCharacterPower(power: editPowerInt)
                self.postCharactersNotification()
                self.dismiss(animated: true, completion: nil)
                return
            }
        }
        self.showAlert("You must type in a number between zero and five", "Wrong input")
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
    
    init() {
        super.init(nibName: "EditPowerPopUp", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private methods
    
    private func postCharactersNotification(){
        let powerEdited = Notification.Name(rawValue: CHARACTERS_TABLE_RELOAD_NOTIFICATION)
        NotificationCenter.default.post(name: powerEdited, object: nil)
    }
    
    private func configureViews() {
        // Add corner radius for the "pop up" view
        self.popUpView.layer.cornerRadius = 8.0
        self.editPowerButton.layer.cornerRadius = 5.0
        self.configureViewEffects()
    }
       
    // Add a blur effect to the background view
    private func configureViewEffects() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.view.bounds
        self.view.addSubview(blurredEffectView)
        self.view.sendSubviewToBack(blurredEffectView)
    }
    
    private func showAlert(_ alertMessage: String,
                               _ alertTitle: String = NSLocalizedString("Error", comment: ""),
                               _ alertActionTitle: String = NSLocalizedString("OK", comment: "")) {

        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
