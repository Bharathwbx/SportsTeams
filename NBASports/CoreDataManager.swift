//
//  CoreDataManager.swift
//  NBASports
//
//  Created by Bharatraj Rai on 2/24/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NBASportsModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed : \(error)")
            }
        }
        return container
    }()
    
    func fetchTeams() -> [Team] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Team>(entityName: "Team")
        do {
            let teams = try context.fetch(fetchRequest)
            return teams
        } catch let fetchErr {
            print("Failed to fetch teams:", fetchErr)
        }
        return []
    }
    
    func createTeam(teamName: String) -> (Team? ,Error?) {
        let context = persistentContainer.viewContext
        let team = NSEntityDescription.insertNewObject(forEntityName: "Team", into: context) as! Team
        team.setValue(teamName, forKey: "name")
        do {
            try context.save()
            return (team, nil)
        } catch let err {
            print("Failed to create a team...", err)
            return (nil, err)
        }
    }
    
    func createPlayer(playerName: String, team: Team) -> (Player? , Error?) {
        let context = persistentContainer.viewContext
        let player = NSEntityDescription.insertNewObject(forEntityName: "Player", into: context) as! Player
        player.team = team
        player.setValue(playerName, forKey: "name")
        do {
            try context.save()
            return(player, nil)
        } catch let err {
            print("Failed to create a player...", err)
            return(nil, err)
        }
    }
}
