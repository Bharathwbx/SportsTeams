//
//  TeamController+UITableView.swift
//  NBASports
//
//  Created by Bharatraj Rai on 2/24/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import UIKit
import CoreData

extension TeamsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TeamTableViewCell else { return UITableViewCell() }
        cell.team = teams[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let team = self.teams[indexPath.row]

        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, indexPath) in
            self.teams.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(team)
            do {
                try context.save()
            } catch let saveErr {
                print("Failed to delete team:", saveErr)
            }
        }
        deleteAction.backgroundColor = .lightRed
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerAction)
        editAction.backgroundColor = .darkBlue
        return [deleteAction, editAction]
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No teams available..."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return teams.count == 0 ? 150 : 0
    }

    private func editHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) {
        let editTeamViewController = CreateTeamViewController()
        editTeamViewController.delegate = self
        editTeamViewController.team = teams[indexPath.row]
        let navController = CustomNavigationController(rootViewController: editTeamViewController)
        present(navController, animated: true, completion: nil)
    }
    
}
