//
//  homeTableViewCell.swift
//  Takefour
//
//  Created by Jonah Lindau on 6/28/23.
//

import UIKit

class homeTableViewCellViewModel {
    let sport_title: String
    let home_team: String
    let away_team: String
    let commence_time: String
    let markets: [Markets]
    
    func printKeyAndPriceData() {
        print("Sport Title: \(sport_title)")
        if markets.isEmpty {
            print("Bookmakers data is not available")
        } else {
            for market in markets {
                print("Key: \(market.key)")
                for outcome in market.outcomes {
                    print("Outcome Price: \(outcome.price)")
                }
            }
        }
    }
    
    init(
        sport_title: String,
        home_team: String,
        away_team: String,
        commence_time: String,
        markets: [Markets]
    ) {
        self.sport_title = sport_title
        self.home_team = home_team
        self.away_team = away_team
        self.commence_time = commence_time
        self.markets = markets
    }
    
}

class homeTableViewCell: UITableViewCell {
    
    static let identifier = "homeTableViewCell"
    
    private let sportTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    private let homeTeamLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let awayTeamLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let commenceTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(sportTitleLabel)
        contentView.addSubview(homeTeamLabel)
        contentView.addSubview(awayTeamLabel)
        contentView.addSubview(commenceTimeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sportTitleLabel.frame = CGRect(x: 10,
                                       y: 0,
                                       width: contentView.frame.size.width - 200,
                                       height: 40
        )
        
        homeTeamLabel.frame = CGRect(x: 10,
                                       y: 45,
                                       width: 160,
                                       height: 20
        )
        awayTeamLabel.frame = CGRect(x: 10,
                                       y: 75,
                                       width: contentView.frame.size.width - 200,
                                       height: 20
        )
        commenceTimeLabel.frame = CGRect(x: 12,
                                         y: 100,
                                         width: contentView.frame.size.width - 200,
                                         height: 15
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func configure(with viewModel: homeTableViewCellViewModel) {
        sportTitleLabel.text = viewModel.sport_title
        homeTeamLabel.text = viewModel.home_team
        awayTeamLabel.text = viewModel.away_team
        commenceTimeLabel.text = viewModel.commence_time

    }
    
}
