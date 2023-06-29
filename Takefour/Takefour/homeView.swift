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

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        APICaller.shared.getTeams { [weak self] apiResponseWrapper in
            switch apiResponseWrapper {
            case .success(let responses):
                self?.viewModels = responses.compactMap({
                    homeTableViewCellViewModel(
                        sport_title: $0.sport_title,
                        home_team: $0.home_team,
                        away_team: $0.away_team,
                        commence_time: $0.commence_time
                    )
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

}
