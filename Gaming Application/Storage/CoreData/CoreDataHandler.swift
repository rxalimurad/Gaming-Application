//
//  CoreDataHandler.swift
//  Gaming Application
//
//  Created by murad on 11/02/2023.
//

import UIKit
import CoreData

protocol LocalDBHandler {
    func saveGame(data: Game?)
    func removeGame(game: GameInfo)
    func getFavGames() -> [Game]
    func getGame(id: Int) -> GameInfo?
    func isGameExist(id: Int) -> Bool
}
class CoreDataHandler: LocalDBHandler {
    
    func isGameExist(id: Int) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameInfo")
        request.predicate = NSPredicate(format: "id == %d" ,id)
        request.fetchLimit =  1
        do {
                let count = try context.count(for: request)
                if count > 0 {
                    return true
                }else {
                    return false
                }
            }catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                return false
            }
    }
    
    func getGame(id: Int) -> GameInfo? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameInfo")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [GameInfo] {
                let dbID = data.value(forKey: "id") as? Int
                if dbID == id {
                    return data
                }
            }
        } catch {
            print("Failed")
        }
        return nil
    }
    
    func removeGame(game: GameInfo) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.delete(game)
        do {
        try context.save()
        }
        catch {
        }
    }
    
    func getFavGames() -> [Game] {
        var games: [Game] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GameInfo")
        request.returnsObjectsAsFaults = false
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let id = data.value(forKey: "id") as? Int
                let title = data.value(forKey: "title") as? String
                let genre = data.value(forKey: "genre") as? String
                let imageURL = data.value(forKey: "imageURL") as? String
                let metacritic = data.value(forKey: "metacritic") as? Int
                let game = Game(id: id, name: title, backgroundImage: imageURL, metacritic: metacritic, genres: [Genre(name: genre)])
                games.append(game)
            }
            
        } catch {
            print("Failed")
        }
        return games
    }
    
    func saveGame(data: Game?) {
        guard let data = data else {
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "GameInfo", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(data.id, forKey: "id")
        newUser.setValue(data.genres?.compactMap{ $0.name }.joined(separator: ", "), forKey: "genre")
        newUser.setValue(data.backgroundImage, forKey: "imageURL")
        newUser.setValue(data.metacritic, forKey: "metacritic")
        newUser.setValue(data.name, forKey: "title")
        do {
            try context.save()
        } catch {
            print("Error saving")
        }
    }
    
    
}
