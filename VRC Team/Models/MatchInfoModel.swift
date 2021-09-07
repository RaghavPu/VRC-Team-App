//
//  MatchInfoModel.swift
//  VRC Team
//
//  Created by Raghav Punnam on 3/7/21.
//  Copyright © 2021 Raghav Punnam. All rights reserved.
//

import Foundation


protocol MatchInfoModelDelegate {
    func didUpdateMatches(_ teamModel: MatchInfoModel, stats: [MatchInfo])
}

struct MatchInfoModel {
    
    var delegate: MatchInfoModelDelegate?
    
    func fetchData(team: String, sku: String) {
        
        if let url = URL(string: "https://api.vexdb.io/v1/get_matches?team=\(team)&sku=" + sku) {
            print("here")
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        DispatchQueue.main.async {
                            do {
                                let statsGotten = try decoder.decode(MatchInfoStats.self, from: safeData)
                                print("here2")

                                self.delegate?.didUpdateMatches(self, stats: statsGotten.result)
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
            }
            task.resume()
        }

    }
}
