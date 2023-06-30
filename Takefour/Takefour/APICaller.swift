//
//  APICaller.swift
//  Takefour
//
//  Created by Jonah Lindau on 6/28/23.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let matchup = URL(string: "https://api.the-odds-api.com/v4/sports/upcoming/odds/?apiKey=032065cd81002cdb9c61dd3d93558e66&regions=us&markets=h2h&oddsFormat=american&bookmakers=fanduel")
    }
    
    private init() {}
    
    public func getTeams(completion: @escaping (Result<[APIResponse], Error>) -> Void) {
        guard let url = Constants.matchup else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                
                do {
                    let apiResponseWrapper = try JSONDecoder().decode(APIResponseWrapper.self, from: data)
                    
                    completion(.success(apiResponseWrapper.responses))
                    
                    let apiResponseArray = apiResponseWrapper.responses
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}


struct APIResponseWrapper: Codable {
    let responses: [APIResponse]
    
    enum CodingKeys: String, CodingKey {
        case responses = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.responses = try container.decode([APIResponse].self)
    }
}

struct APIResponse: Codable {
    let sport_title: String
    let home_team: String
    let away_team: String
    let commence_time: String
    let bookmakers: [Bookmakers]?
}

struct Bookmakers: Codable {
    let markets: [Markets]
}

struct Markets: Codable {
    let key: String
    let outcomes: [Outcomes]
}

struct Outcomes: Codable {
    let price: Int
}
