//
//  TeamController+CreateTeam.swift
//  NBASports
//
//  Created by Bharatraj Rai on 2/24/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import Foundation
extension TeamsViewController: CreateTeamViewControllerDelegate {
    func didAddTeam(_ team: Team) {
        teams.append(team)
        let newIndexPath = IndexPath(row: teams.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    func didEditTeam(_ team: Team) {
        let row = teams.firstIndex(of: team)
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .middle)
    }


}
