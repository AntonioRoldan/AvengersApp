//
//  Character.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 24/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import Foundation

struct Character { //Estructura que se pasa al character cell, si la celda es para una tabla de héroes se le asigna un héroe, si es de villanos un villano
    let hero: Hero?
    let villain: Villain?
}
