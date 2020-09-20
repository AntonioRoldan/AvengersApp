//
//  Database.swift
//  AvengersApp
//
//  Created by Antonio Miguel Roldan de la Rosa on 23/04/2020.
//  Copyright © 2020 Antonio Roldan de la Rosa. All rights reserved.
//

import UIKit
import CoreData

class CoreDatabase : CoreDataDelegate {
    
    var context: NSManagedObjectContext? {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
           return appDelegate.persistentContainer.viewContext
    }
       
    func createDataHeroe() -> Hero? {
        guard let context = self.context, let entity = NSEntityDescription.entity(forEntityName: ENTITY_HEROE, in: context) else { return nil }
        return Hero(entity: entity, insertInto: context)
    }
    
    func createDataVillain() -> Villain? {
        guard let context = self.context, let entity = NSEntityDescription.entity(forEntityName: ENTITY_VILLAIN, in: context) else { return nil }
        return Villain(entity: entity, insertInto: context)
    }
    
    func createDataBattle() -> Battle? {
        guard let context = self.context, let entity = NSEntityDescription.entity(forEntityName: ENTITY_BATTLE, in: context) else { return nil }
        return Battle(entity: entity, insertInto: context)
    }
    
    func persistHeroe(heroe: Hero) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.saveContext()
    }
       
    func persistVillain(villain: Villain) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.saveContext()
    }
       
    func persistBattle(battle: Battle) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.saveContext()
    }
       
    
    func fetchHeroes() -> [Hero]? {
        return try? self.context?.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_HEROE)) as? [Hero]
    }
    
    func fetchVillains() -> [Villain]? {
        return try? self.context?.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_VILLAIN)) as? [Villain]
    }
    
    func fetchBattles() -> [Battle]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_BATTLE)
        let predicate = NSPredicate(format: "\(ENTITY_BATTLE_HEROE) != nil AND \(ENTITY_BATTLE_VILLAIN) != nil")
        request.predicate = predicate
        return try? self.context?.fetch(request) as? [Battle]
    }
    
    func deleteBattle(battle: Battle) {
        context?.delete(battle)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.saveContext()
    }
    
    func deleteIncompleteBattles() {
        //Si la aplicación se cerró en las pantallas de selección, hay que borrar las batallas que se quedaron incompletas si el contexto fue guardado automáticamente al cerrar la aplicación
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_BATTLE)
        let predicate = NSPredicate(format: "\(ENTITY_BATTLE_HEROE) == nil OR \(ENTITY_BATTLE_VILLAIN) == nil")
        fetchRequest.predicate = predicate
        let incompleteBattles = try? context?.fetch(fetchRequest) as? [Battle]
        guard let battlesToBeDeleted = incompleteBattles else { return }
        for battle in battlesToBeDeleted{
            context?.delete(battle)
        }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.saveContext()
    }
    
    func editHerosPower(power: Int, name: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_HEROE)
        let predicate = NSPredicate(format: "%@ == %@", ENTITY_HEROE_NAME, name)
        fetchRequest.predicate = predicate
        guard let hero = try? self.context?.fetch(fetchRequest) as? [Hero] else { return }
        let heroToEdit = hero[0]
        heroToEdit.power = Int16(power)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.saveContext()
    }
    
    func editVillainsPower(power: Int, name: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY_VILLAIN)
        let predicate = NSPredicate(format: "%@ == %@", ENTITY_VILLAIN_NAME, name)
        fetchRequest.predicate = predicate
        guard let villain = try? context?.fetch(fetchRequest) as? [Villain] else { return }
        let villainToEdit = villain[0]
        villainToEdit.power = Int16(power)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.saveContext()
    }
}
