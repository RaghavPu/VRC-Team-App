//
//  TeamModel.swift
//  VRC Team
//
//  Created by Raghav Punnam on 8/9/20.
//  Copyright © 2020 Raghav Punnam. All rights reserved.
//

import Foundation

protocol TeamsMultipleModelDelegate {
    //func didUpdateInfo(_ teamModel: TeamModel, stats: [TeamInfo])
    func didUpdateTeams(_ teamModel: TeamsMultipleModel, stats: [TeamInfo])
}

struct TeamsMultipleModel {
    
    var delegate: TeamsMultipleModelDelegate?
    
//    func fetchData() {
//        if let url = URL(string: "https://api.vexdb.io/v1/get_teams?team=33A") {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error == nil {
//                    let decoder = JSONDecoder()
//                    if let safeData = data {
//                        do {
//                            let statsGotten = try decoder.decode(Stats.self, from: safeData)
//                            self.delegate?.didUpdateInfo(self, stats: statsGotten.result)
//                        } catch {
//                            print(error)
//                        }
//                    }
//                }
//            }
//            task.resume()
//        }
//
//    }
    
    
    
    
}



//MARK: - Fetch All Teams Helper Methods
extension TeamsMultipleModel {
    
    // Fetch Teams
    func fetchTeams() {
        
        var totalTeams: Int?
        var dispatchGroup = DispatchGroup()
        
        if let sizeUrl = URL(string: "https://api.vexdb.io/v1/get_teams?nodata=true") {
            let session = URLSession(configuration: .default)
            
            dispatchGroup.enter()
            let sizeTask = session.dataTask(with: sizeUrl) { (sizeData, sizeResponse, sizeError) in
                if sizeError == nil {
                    
                    defer {
                        dispatchGroup.leave()
                        print("Left")
                    }
                    
                    let decoder = JSONDecoder()
                    
                    
                    if let safeData = sizeData {
                        do {
                            let statsGotten = try decoder.decode(TeamStats.self, from: safeData)
                            print(statsGotten.size)
                            totalTeams = statsGotten.size
                            print(totalTeams!)
                            //infoArray = Array(Set(infoArray + statsGotten.result))
                            //self.delegate?.didUpdateTeams(self, stats: statsGotten.result)
                            
                        } catch {
                            print(error)
                            dispatchGroup.leave()
                        }
                        
                    }
                }
                
            }
            sizeTask.resume()
            
            dispatchGroup.notify(queue: .main) {
                self.fetchTotalTeamsBy5000(for: totalTeams!)
            }
        }
    }
    
    
    // Fetch Teams by 5000
    func fetchTotalTeamsBy5000(for totalTeams: Int) {
        
        var infoArray = [TeamInfo]()
        var dispatchGroup = DispatchGroup()
        
        for limitStart in stride(from: 0, to: totalTeams, by: 5000) {
            
            
            if let url = URL(string: "https://api.vexdb.io/v1/get_teams?limit_start=\(limitStart)") {
                let session = URLSession(configuration: .default)
                
                dispatchGroup.enter()
                print("Entered")
                
                let task = session.dataTask(with: url) { (data, response, error) in
                    
                    
                    if error == nil {
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                
                                defer {
                                    dispatchGroup.leave()
                                    print("Left Individual")
                                }
                                
                                let statsGotten = try decoder.decode(TeamStats.self, from: safeData)
                                
                                DispatchQueue.main.async {
                                    infoArray = Array(Set(infoArray + statsGotten.result))
                                }
                                print("\(infoArray.count) : \(totalTeams)")
                                
                            } catch {
                                print(error)
                            }
                        }
                    }
                    
                    
                    
                }
                task.resume()
            }
            
        }
        
        
        dispatchGroup.notify(queue: .main) {
            print("\(infoArray.count) : Done With Everything")
            self.delegate?.didUpdateTeams(self, stats: infoArray)
        }
    }
    
    
}


//MARK: - Fetch Event and Season Info
//extension fetch
