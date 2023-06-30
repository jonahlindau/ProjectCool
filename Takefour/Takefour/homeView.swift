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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 21/255, green: 38/255, blue: 52/255, alpha: 1.0)
        tableView.register(homeTableViewCell.self, forCellReuseIdentifier: homeTableViewCell.identifier)

        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        APICaller.shared.getTeams { [weak self] result in
            switch result {
            case .success(let responses):
                self?.viewModels = responses.compactMap({ response in
                        let markets = response.bookmakers?.flatMap({ $0.markets}) ?? []
                        let viewModel = homeTableViewCellViewModel(
                        sport_title: response.sport_title,
                        home_team: response.home_team,
                        away_team: response.away_team,
                        commence_time: response.commence_time,
                        markets: markets
                        )
                        viewModel.printKeyAndPriceData()
                        return viewModel
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return "Header"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: homeTableViewCell.identifier,
            for: indexPath
        ) as? homeTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
}
