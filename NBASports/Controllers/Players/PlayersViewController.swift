//
//  PlayersViewController.swift
//  NBASports
//
//  Created by Bharatraj Rai on 2/24/20.
//  Copyright © 2020 Bharatraj Rai. All rights reserved.
//

import UIKit
import CoreData

class PlayersViewController: UITableViewController, CreatePlayerViewControllerDelegate {
    
    var team: Team?
    var players = [Player]()
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPlayers()
        tableView.backgroundColor = UIColor.darkBlue
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
        navigationItem.title = team?.name
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    @objc private func handleAdd() {
        let createPlayerViewController = CreatePlayerViewController()
        createPlayerViewController.delegate = self
        createPlayerViewController.team = team
        let navController = CustomNavigationController(rootViewController: createPlayerViewController)
        
        present(navController, animated: true, completion: nil)
    }
    
    private func fetchPlayers() {
        guard let teamPlayers = team?.players?.allObjects as? [Player] else { return }
        players = teamPlayers
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let player = players[indexPath.row]
        cell.textLabel?.text = player.name
        cell.backgroundColor = .tearColor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .boldSystemFont(ofSize: 15)
        return cell
    }
    
//    MARK: CreatePlayerViewControllerDelegate method
    func didAddPlayer(_ player: Player) {
        players.append(player)
        tableView.reloadData()
    }

    
}
