//
//  MatchesViewController.swift
//  VRC Team
//
//  Created by Raghav Punnam on 12/23/20.
//  Copyright © 2020 Raghav Punnam. All rights reserved.
//

import UIKit

class MatchesViewController: UITableViewController, MatchCellDelegate {
    
    var team: TeamInfo? = nil
    var sku: String? = nil;
    
    var teamForSegue: TeamInfo?
    var teamModel: TeamModel = TeamModel()
    
    var matchesModel = MatchInfoModel();
    var matches: [MatchInfo]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        teamModel.delegate = self
        
        matchesModel.delegate = self;

        matchesModel.fetchData(team: team?.number ?? "", sku: sku! )
        
        tableView.register(UINib(nibName: Constants.matchInformationCellNibName, bundle: nil), forCellReuseIdentifier: Constants.matchInformationCellIdentifier)
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return matches?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let currentCell = tableView.cellForRow(at: indexPath) as? MatchInfoCell {
//            if (currentCell.teamSelected) {
//                print(currentCell.teamName)
//                performSegue(withIdentifier: Constants.segueFromMatchesToTeam, sender: self)
//            }
//        }
        
    }
    
    func selectTeam(tag: String) {
        
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            self.teamModel.fetchData(team: tag, group: group)
            print("Doing this")
        }
        group.notify(queue: .main) {
            self.performSegue(withIdentifier: Constants.segueFromMatchesToTeam, sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.matchInformationCellIdentifier, for: indexPath) as! MatchInfoCell
        cell.delegate = self
        cell.blueOne.setTitle(matches![indexPath.row].blue1, for: .normal)
        cell.blueTwo.setTitle(matches![indexPath.row].blue2, for: .normal)
        cell.redOne.setTitle(matches![indexPath.row].red1, for: .normal)
        cell.redTwo.setTitle(matches![indexPath.row].red2, for: .normal)
        cell.blueScore.text = String(matches![indexPath.row].bluescore)
        cell.redScore.text = String(matches![indexPath.row].redscore)
        cell.roundAndMatch.text = "Round " + String(matches![indexPath.row].round) +
            ": Match " + String(matches![indexPath.row].matchnum);
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueFromMatchesToTeam {
            let destinationVC = segue.destination as! TeamMainInfoViewController
            destinationVC.team = teamForSegue
        }
    }

}

extension MatchesViewController: TeamModelDelegate {
    func didUpdateTeam(_ teamModel: TeamModel, stats: TeamInfo) {
        print("Done")
        self.teamForSegue = stats
    }
}

extension MatchesViewController: MatchInfoModelDelegate {
    func didUpdateMatches(_ teamModel: MatchInfoModel, stats: [MatchInfo]) {
        print(stats[0].blue1)
        matches = stats
//        matches?.sorted(by: {$0.round > $1.round})
//        matches = matches?.sort()
        tableView.reloadData();
    }
}
