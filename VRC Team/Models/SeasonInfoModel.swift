//
//  TeamInfoModel.swift
//  VRC Team
//
//  Created by Raghav Punnam on 8/11/20.
//  Copyright © 2020 Raghav Punnam. All rights reserved.
//

import Foundation

protocol SeasonInfoModelDelegate {
    func didUpdateSeasonInfo(_ seasonInfoModel: SeasonInfoModel, stats: [SeasonInfo])
}

struct SeasonInfoModel {
    
    var delegate: SeasonInfoModelDelegate?
    
    func fetchEvents(team: String) {
        if let url = URL(string: "https://api.vexdb.io/v1/get_season_rankings?team=\(team)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let statsGotten = try decoder.decode(SeasonStats.self, from: safeData)
                            self.delegate?.didUpdateSeasonInfo(self, stats: statsGotten.result)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }

    }

}
