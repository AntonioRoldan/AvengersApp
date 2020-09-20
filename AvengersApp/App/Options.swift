//
//  Options.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 23/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import Foundation

struct Options {
    /*
     Pasaremos esta estructura como parametro al constructor de un view controller que servirá para mostrar tanto a los villanos como a los héroes por separado
     */
    let isVillain : Bool //Para determinar si el view controller mostrará datos de héros o villanos
    let loadedFromBattle: Bool //Para determinar si el view controller ha sido cargado desde battles en cuyo caso será una pantalla para seleccionar a los participantes de una batalla o desde un tab 
}
