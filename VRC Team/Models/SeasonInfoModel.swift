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

protocol SeasonDataDelegate {
    func didUpdateSeasonEventsInfo(_ seasonInfoModel: SeasonInfoModel, stats: EventInfo)
}

struct SeasonInfoModel {
    
    
    var delegate: SeasonInfoModelDelegate?
    var dataDelegate: SeasonDataDelegate?
    
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
    
    
    func fetchMatches(team: String, season: String) {
        let formattedSeason = season.replacingOccurrences(of: " ", with: "%20")
        if let url = URL(string: "https://api.vexdb.io/v1/get_events?team=\(team)&season=\(formattedSeason)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let statsGotten = try decoder.decode(EventDetailsStats.self, from: safeData)
                            self.fetchMatchPerformanceInfo(team: team, season: formattedSeason, statsGotten: statsGotten)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }

    }
    
    func fetchMatchPerformanceInfo(team: String, season: String, statsGotten: EventDetailsStats)
    {
        if let url = URL(string: "https://api.vexdb.io/v1/get_rankings?team=\(team)&season=\(season)") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let performanceStatsGotten = try decoder.decode(EventPerformanceStats.self, from: safeData)
                            
                            let eventsInfo: EventInfo = self.sortEventStats(eventDetailsGotten: statsGotten, eventPerformanceGotten: performanceStatsGotten)
                            self.dataDelegate?.didUpdateSeasonEventsInfo(self, stats: eventsInfo)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func sortEventStats(eventDetailsGotten: EventDetailsStats, eventPerformanceGotten: EventPerformanceStats) -> EventInfo {
        var eventDetails = eventDetailsGotten
        
        if (eventDetails.size > 2) {
            for i in 1..<eventDetails.size - 1 {
                let currentEvent = eventDetails.result[i]
                var j = i - 1;
                while (j >= 0 && currentEvent.end > eventDetails.result[j].end)
                {
                    eventDetails.result[j + 1] = eventDetails.result[j]
                    j -= 1
                }
                eventDetails.result[j] = currentEvent
            }
        }
        
//        var eventPerformance = [EventPerformanceInfo?](repeating: nil, count: eventPerformanceGotten.size)
//        for i in 0..<eventPerformance.count {
//            for j in 0..<eventDetails.size {
//                if (eventDetails.result[j].sku == eventPerformanceGotten.result[i].sku) {
//                    eventPerformance[j] = eventPerformanceGotten.result[i]
//                    break;
//                }
//            }
//        }
        
        return EventInfo(eventDetails: eventDetails.result, eventPerformance: eventPerformanceGotten.result)
    }
    

}
