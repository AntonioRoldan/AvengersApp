//
//  Validation.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 30/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import Foundation

class Validation {
    
    static let shared = Validation()
    
    private init() {}
    
    func validateEditPower(editPowerInput: String) -> Bool{
        let editPowerInputRegex = "^([0-5]|1)$"
        let trimmedString = editPowerInput.trimmingCharacters(in: .whitespaces)
        let validateInput = NSPredicate(format: "SELF MATCHES %@", editPowerInputRegex)
        let isValidInput = validateInput.evaluate(with: trimmedString)
        return isValidInput
    }
}
