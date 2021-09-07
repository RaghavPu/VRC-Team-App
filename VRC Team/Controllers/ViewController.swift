//
//  ViewController.swift
//  VRC Team
//
//  Created by Raghav Punnam on 8/9/20.
//  Copyright © 2020 Raghav Punnam. All rights reserved.
//

import UIKit

class TeamsListViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var teamModel = TeamModel()
    
    var teams = [Info]()
    var searchedTeams = [Info]()
    var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBar.delegate = self
        
        tableView.register(UINib(nibName: Constants.teamsCellNibName, bundle: nil), forCellReuseIdentifier: Constants.teamSearchCellIdentifier)
        
        teamModel.delegate = self
        teamModel.fetchData()
        teamModel.fetchTeams()
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
//        print(teamModel.stats[0].number)
//        print(teamModel.stats[0].team_name)
//        print(teamModel.stats[0].city)
//        print(teamModel.stats[0].region)
        
    }
    


}

//MARK: - TeamModelDelegate
extension TeamsListViewController: TeamModelDelegate {
    func didUpdateTeams(_ teamModel: TeamModel, stats: [Info]) {
        DispatchQueue.main.async {
            for team in stats {
                self.teams.append(team)
                //print(team.number + " - " + team.team_name)
            }
            
            print("There are \(stats.count) teams in tableView")
            self.tableView.reloadData()
        }
    }
    
    func didUpdateInfo(_ teamModel: TeamModel, stats: [Info]) {
        DispatchQueue.main.async {
            print(stats[0].number)
            print(stats[0].team_name)
            print(stats[0].city)
            print(stats[0].region)


        }
    }
}


//MARK: - Table View Config
extension TeamsListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searching {
            return teams.count
        } else {
            return searchedTeams.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.teamSearchCellIdentifier, for: indexPath) as! TeamsListCell
        
        if !searching {
            cell.teamNumberLabel.text = teams[indexPath.row].number
            cell.teamNameLabel.text = teams[indexPath.row].team_name
        } else {
            cell.teamNumberLabel.text = searchedTeams[indexPath.row].number
            cell.teamNameLabel.text = searchedTeams[indexPath.row].team_name
        }
        return cell
    }
}


//MARK: - Search Bar Delegate
extension TeamsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            
            searchedTeams = []
            
            for team in teams {
                if team.number.lowercased().contains(searchText.lowercased()) || team.team_name.lowercased().contains(searchText.lowercased()) {
                    searchedTeams.append(team)
                }
            }
            
            
        }
        
        searching = searchText != ""
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.endEditing(true)
        searchBar.text = ""
        searching = false
        tableView.reloadData()
    }
}


