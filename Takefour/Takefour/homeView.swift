//
//  homeView.swift
//  Takefour
//
//  Created by Jonah Lindau on 5/19/23.
//

import UIKit

class homeView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: homeTableViewCell.identifier)
        return table
    }()
    
    private var viewModels = [homeTableViewCellViewModel]()
    
    private var viewModelsDict = [String: [homeTableViewCellViewModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(red: 21/255, green: 38/255, blue: 52/255, alpha: 1.0)
        tableView.register(homeTableViewCell.self, forCellReuseIdentifier: homeTableViewCell.identifier)
        tableView.separatorColor = UIColor(red: 21/255, green: 38/255, blue: 52/255, alpha: 1.0)
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        func toInt(_ string: String) -> Int? {
            return Int(string)
        }
        
        APICaller.shared.getTeams { [weak self] result in
            switch result {
            case .success(let responses):
//                var viewModelDict: [String: [homeTableViewCellViewModel]] = [:]
                self?.viewModels = responses.compactMap({ response in
                    let markets = response.bookmakers?.flatMap({ $0.markets }) ?? []
                    let outcomes: [Outcomes] = markets.flatMap { market in
                        market.outcomes.compactMap{ outcome in
                            return Outcomes(price: outcome.price)
                        }
                    }
                    let viewModel = homeTableViewCellViewModel(
                    sport_title: response.sport_title,
                    home_team: response.home_team,
                    away_team: response.away_team,
                    commence_time: response.commence_time,
                    markets: markets,
                    outcomes: outcomes
                    )
                    viewModel.printKeyAndPriceData()
                    return viewModel
                })
                
                self?.viewModels.sort(by: { $0.sport_title < $1.sport_title })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
                self?.viewModelsDict = Dictionary(grouping: responses.compactMap { response in
                    let markets = response.bookmakers?.flatMap { $0.markets } ?? []
                    let outcomes: [Outcomes] = markets.flatMap { market in
                        market.outcomes.compactMap { outcome in
                            return Outcomes(price: outcome.price)
                        }
                    }
                    return homeTableViewCellViewModel(
                        sport_title: response.sport_title,
                        home_team: response.home_team,
                        away_team: response.away_team,
                        commence_time: response.commence_time,
                        markets: markets,
                        outcomes: outcomes
                    )
                }, by: { $0.sport_title })
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModelsDict.keys.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sportTitles = Array(viewModelsDict.keys)
        return sportTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sportTitles = Array(viewModelsDict.keys)
        let sportTitle = sportTitles[section]
        return viewModelsDict[sportTitle]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: homeTableViewCell.identifier,
            for: indexPath
        ) as? homeTableViewCell else {
            fatalError()
        }
        
        let sportTitles = Array(viewModelsDict.keys)
        let sportTitle = sportTitles[indexPath.section]
        if let viewModels = viewModelsDict[sportTitle] {
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemGray3 // Set the background color
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20) // Set the font
        titleLabel.textColor = .black // Set the text color
        titleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        headerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        return headerView
    }

    
}
