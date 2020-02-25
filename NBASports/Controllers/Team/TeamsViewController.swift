//
//  TeamsViewController.swift
//  NBASports
//
//  Created by Bharatraj Rai on 2/23/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import UIKit
import CoreData

class TeamsViewController: UITableViewController {
    
    var teams: [Team] = []
    let cellID = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTeams()
        navigationController?.setupNavigationalController()
        navigationItem.title = "NBA Teams"
        view.backgroundColor = .darkBlue
        
        tableView.register(TeamTableViewCell.self, forCellReuseIdentifier: cellID)
        setupPlusButtonInNavBar(selector: #selector(handleAddTeam))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
    }
    
    @objc func handleAddTeam() {
        let createTeamViewController = CreateTeamViewController()
        createTeamViewController.delegate = self
        let navController = CustomNavigationController(rootViewController: createTeamViewController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc private func handleReset() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Team.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
            var indexPathToRemove = [IndexPath]()
            for (index, _) in teams.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathToRemove.append(indexPath)
            }
            teams.removeAll()
            tableView.deleteRows(at: indexPathToRemove, with: .left)
        } catch let delErr {
            print("Failed to delete the objects....", delErr)
        }
    }
    
    private func fetchTeams() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request = NSFetchRequest<Team>(entityName: "Team")
        do {
            let teams = try context.fetch(request)
            self.teams = teams
        } catch let err {
            print("Error occured while fetching employee:", err)
        }
    }
        
}

