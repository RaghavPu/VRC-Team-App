//
//  TeamMainInfoViewController.swift
//  VRC Team
//
//  Created by Raghav Punnam on 8/10/20.
//  Copyright © 2020 Raghav Punnam. All rights reserved.
//

import UIKit

class TeamMainInfoViewController: UITableViewController {
    
    var team: TeamInfo? = nil
    
    var mainInfoTableData: [IndividualTeamTableInfo] = [IndividualTeamTableInfo]()
    var seasonInfoTableData: [SeasonInfo] = [SeasonInfo]()
    
    var seasonPicked: Int = 0
    
    var seasonInfoModel = SeasonInfoModel()
        

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        seasonInfoModel.delegate = self
        
        title = team!.number
        
        addMainTeamInfoToArray()
        
        if let teamNumber = team?.number {
            seasonInfoModel.fetchEvents(team: teamNumber)
        }
                
        tableView.register(UINib(nibName: Constants.teamInfoCellNibName, bundle: nil), forCellReuseIdentifier: Constants.teamInfoCellIndendifier)
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        title = team!.number
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = "Back"
    }
    
    //MARK: - Main Team Info
    func addMainTeamInfoToArray() {
        
        mainInfoTableData.append(IndividualTeamTableInfo(content: /* Name */ Constants.teamMainInfoGroupNames[0], value: team?.team_name ?? ""))
        mainInfoTableData.append(IndividualTeamTableInfo(content: /* Organization */ Constants.teamMainInfoGroupNames[1], value: team?.organisation ?? ""))
        mainInfoTableData.append(IndividualTeamTableInfo(content: /* Program */ Constants.teamMainInfoGroupNames[2], value: team?.program ?? ""))
        mainInfoTableData.append(IndividualTeamTableInfo(content: /* Grade */ Constants.teamMainInfoGroupNames[3], value: team?.grade ?? ""))
        mainInfoTableData.append(IndividualTeamTableInfo(content: /* City */ Constants.teamMainInfoGroupNames[4], value: team?.city ?? ""))
        mainInfoTableData.append(IndividualTeamTableInfo(content: /* Region */ Constants.teamMainInfoGroupNames[5], value: team?.region ?? ""))
        mainInfoTableData.append(IndividualTeamTableInfo(content: /* Country */ Constants.teamMainInfoGroupNames[6], value: team?.country ?? ""))
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1) {
            seasonPicked = indexPath.row
            print("REACHED THE SEGUE");
            performSegue(withIdentifier: Constants.segueFromTeamToSeasonPerformance, sender: self)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Constants.numberOfTableSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? mainInfoTableData.count : seasonInfoTableData.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.teamInfoCellIndendifier, for: indexPath) as! TeamInfoCell

        // Configure the cell...
        if indexPath.section == 0 {
            cell.contentLabel.text = mainInfoTableData[indexPath.row].content
            cell.valueLabel.text = mainInfoTableData[indexPath.row].value
        } else if indexPath.section == 1 {
            cell.contentLabel.text = seasonInfoTableData[indexPath.row].season
            cell.valueLabel.text = ""
            cell.accessoryType = .detailDisclosureButton
        }

        return cell
    }


    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == Constants.segueFromTeamToSeasonPerformance {
            let destinationVC = segue.destination as! SeasonViewController
            destinationVC.team = team
            destinationVC.seasonInfo = seasonInfoTableData[seasonPicked]
        }
    }

}


//MARK: - Fetch Season Info
extension TeamMainInfoViewController: SeasonInfoModelDelegate {
    func didUpdateSeasonInfo(_ seasonInfoModel: SeasonInfoModel, stats: [SeasonInfo]) {
        DispatchQueue.main.async {
            self.seasonInfoTableData = stats
            self.tableView.reloadData()
        }
    }
    
    
}
