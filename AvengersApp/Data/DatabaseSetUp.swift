//
//  DatabaseSetUp.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 24/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import Foundation

func setUpDatabaseData(dataProvider: DataProvider){
    setUpCharacter(dataProvider: dataProvider, isVillain: false, name: "Captain america", description: "", power: 0, image: "america_captain")
    setUpCharacter(dataProvider: dataProvider, isVillain: false, name: "Black panther", description: "", power: 0, image: "black_panther")
    setUpCharacter(dataProvider: dataProvider, isVillain: false, name: "Black widow", description: "", power: 0, image: "black_widow")
    setUpCharacter(dataProvider: dataProvider, isVillain: false, name: "Dr strange", description: "", power: 0, image: "dr_strange")
    setUpCharacter(dataProvider: dataProvider, isVillain: false, name: "Gamora", description: "", power: 0, image: "gamora")
    setUpCharacter(dataProvider: dataProvider, isVillain: false, name: "Hulk", description: "", power: 0, image: "hulk")
    setUpCharacter(dataProvider: dataProvider, isVillain: false, name: "Ironman", description: "", power: 0, image: "ironman")
    setUpCharacter(dataProvider: dataProvider, isVillain: false, name: "Captain marvel", description: "", power: 0, image: "marvel_captain")
    setUpCharacter(dataProvider: dataProvider, isVillain: false, name: "Spiderman", description: "", power: 0, image: "spiderman")
    setUpCharacter(dataProvider: dataProvider, isVillain: false, name: "Thor", description: "", power: 0, image: "thor")
    setUpCharacter(dataProvider: dataProvider, isVillain: true, name: "Dormammu", description: "", power: 0, image: "dormammu")
      setUpCharacter(dataProvider: dataProvider, isVillain: true, name: "Ego", description: "", power: 0, image: "ego")
      setUpCharacter(dataProvider: dataProvider, isVillain: true, name: "Hela", description: "", power: 0, image: "hela")
      setUpCharacter(dataProvider: dataProvider, isVillain: true, name: "Ivan Vanko", description: "", power: 0, image: "ivan_vanko")
      setUpCharacter(dataProvider: dataProvider, isVillain: true, name: "Johann Schmidt", description: "", power: 0, image: "johann_schmidt")
      setUpCharacter(dataProvider: dataProvider, isVillain: true, name: "Malekith", description: "", power: 0, image: "malekith")
      setUpCharacter(dataProvider: dataProvider, isVillain: true, name: "Ronan", description: "", power: 0, image: "ronan")
      setUpCharacter(dataProvider: dataProvider, isVillain: true, name: "Thanos", description: "", power: 0, image: "thanos")
      setUpCharacter(dataProvider: dataProvider, isVillain: true, name: "Ultron", description: "", power: 0, image: "ultron")
      setUpCharacter(dataProvider: dataProvider, isVillain: true, name: "Yon Rogg", description: "", power: 0, image: "yon_rogg")
}

func setUpCharacter(dataProvider: DataProvider, isVillain: Bool, name: String, description: String, power: Int, image: String){
    var hero: Hero?
    var villain: Villain?
    if(isVillain) {
        villain = dataProvider.createVillain()
        hero = nil
    } else {
        hero = dataProvider.createHeroe()
        villain = nil
    }
    if let heroe = hero {
        heroe.name = name
        heroe.bio = description
        heroe.image = "img_heroe_\(image)"
        heroe.power = 0
        dataProvider.saveHeroe(heroe: heroe)
        return
    } else if let villain = villain {
        villain.name = name
        villain.bio = description
        villain.image = "img_villain_\(image)"
        villain.power = 0
        dataProvider.saveVillain(villain: villain)
        return
    }
    fatalError("Could not unwrap character")
}
