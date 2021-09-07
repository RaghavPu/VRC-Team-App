//
//  SeasonViewController.swift
//  VRC Team
//
//  Created by Raghav Punnam on 11/19/20.
//  Copyright © 2020 Raghav Punnam. All rights reserved.
//

import UIKit

class SeasonViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var team: TeamInfo? = nil
    var seasonInfo: SeasonInfo? = nil
    
    var eventInfo: EventInfo? = nil
    
    var seasonInfoModel = SeasonInfoModel()
    
    var eventPicked = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.\
        
        tableView.dataSource = self
        tableView.delegate = self
        
        title = team?.number
        navigationItem.prompt = seasonInfo?.season
//        navigationController?.navigationBar.topItem?.title = "Hey"
        
        tableView.register(UINib(nibName: Constants.ratingCellNibName, bundle: nil), forCellReuseIdentifier: Constants.ratingCellIdentifier)
        tableView.register(UINib(nibName: Constants.eventInformationCellNibName, bundle: nil), forCellReuseIdentifier: Constants.eventInformationCellIdentifier)

        
        
        seasonInfoModel.dataDelegate = self
        seasonInfoModel.fetchMatches(team: team?.number ?? "N/A", season: seasonInfo?.season ?? "N/A")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.navigationBar.topItem?.title = team?.number

    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        navigationController?.navigationBar.topItem?.title = team?.number
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SeasonViewController: UITableViewDelegate {

}

extension SeasonViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
//        return Constants.seasonPerformanceTableSections
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? Constants.numberOfSeasonRatings : eventInfo?.eventPerformance.count ?? 0
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ratingCellIdentifier, for: indexPath) as! RatingCell
            cell.title.text = Constants.ratingIdentifiers[indexPath.row]
            if (indexPath.row == 0) {
                let rating = seasonInfo!.vrating_rank
                cell.content.text = "\(rating)"
            } else {
                let rating = seasonInfo!.vrating
                cell.content.text = "\(rating)"
            }
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.eventInformationCellIdentifier, for: indexPath) as! EventInformationCell
            cell.eventName.text = eventInfo?.eventDetails[indexPath.row]?.name
            cell.eventRegion.text = eventInfo?.eventDetails[indexPath.row]?.loc_region
            cell.rank.text = "\(eventInfo?.eventPerformance[indexPath.row]?.rank ?? 0)"
            cell.wins.text = "\(eventInfo?.eventPerformance[indexPath.row]?.wins ?? 0)"
            cell.losses.text = "\(eventInfo?.eventPerformance[indexPath.row]?.losses ?? 0)"
            cell.ties.text = "\(eventInfo?.eventPerformance[indexPath.row]?.ties ?? 0)"
            cell.wp.text = "\(eventInfo?.eventPerformance[indexPath.row]?.wp ?? 0)"
            cell.ap.text = "\(eventInfo?.eventPerformance[indexPath.row]?.ap ?? 0)"
            cell.sp.text = "\(eventInfo?.eventPerformance[indexPath.row]?.sp ?? 0)"
            cell.trsp.text = "\(eventInfo?.eventPerformance[indexPath.row]?.trsp ?? 0)"
            cell.maxScore.text = "\(eventInfo?.eventPerformance[indexPath.row]?.max_score ?? 0)"
            cell.opr.text = "\(eventInfo?.eventPerformance[indexPath.row]?.opr ?? 0)"
            cell.dpr.text = "\(eventInfo?.eventPerformance[indexPath.row]?.dpr ?? 0)"
            cell.ccwm.text = "\(eventInfo?.eventPerformance[indexPath.row]?.ccwm ?? 0)"
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: Constants.ratingCellIdentifier, for: indexPath) as! RatingCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1) {
            eventPicked = eventInfo?.eventDetails[indexPath.row]?.sku ?? ""
            performSegue(withIdentifier: Constants.segueFromSeasonPerformanceToMatches, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueFromSeasonPerformanceToMatches {
            let destinationVC = segue.destination as! MatchesViewController
            destinationVC.team = team
            destinationVC.sku = eventPicked
        }
    }
    
//
//
}

extension SeasonViewController: SeasonDataDelegate {
    func didUpdateSeasonEventsInfo(_ seasonInfoModel: SeasonInfoModel, stats: EventInfo) {
        DispatchQueue.main.async {
            self.eventInfo = stats
            self.tableView.reloadData()
        }
    }
    
    
}
