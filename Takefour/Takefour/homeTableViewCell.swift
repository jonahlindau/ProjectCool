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
    var outcomes: [Outcomes]
    
    let ml = "Moneyline"
    
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
        markets: [Markets],
        outcomes: [Outcomes]
    ) {
        self.sport_title = sport_title
        self.home_team = home_team
        self.away_team = away_team
        self.commence_time = commence_time
        self.markets = markets
        self.outcomes = outcomes
    }
    
}

class homeTableViewCell: UITableViewCell {
    
    static let identifier = "homeTableViewCell"
    
    private let sportTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let homeTeamLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let awayTeamLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let commenceTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let mlLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 8, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let h2hHomeOddsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 21/255, green: 38/255, blue: 52/255, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.layer.cornerRadius = 5
        return button
    }()

    private let h2hAwayOddsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 21/255, green: 38/255, blue: 52/255, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private func setButtonOutline(button: UIButton) {
        button.layer.borderWidth = 1.0 // Set the border width as desired
        button.layer.borderColor = UIColor.white.cgColor // Set the border color as desired
        button.layer.cornerRadius = 5.0 // Set the corner radius as desired to get rounded corners
        // Add any other customizations for your button here
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 21/255, green: 38/255, blue: 52/255, alpha: 1.0)
        contentView.addSubview(sportTitleLabel)
        contentView.addSubview(homeTeamLabel)
        contentView.addSubview(awayTeamLabel)
        contentView.addSubview(commenceTimeLabel)
        contentView.addSubview(h2hHomeOddsButton)
        contentView.addSubview(h2hAwayOddsButton)
        contentView.addSubview(mlLabel)
        
        setButtonOutline(button: h2hHomeOddsButton)
        setButtonOutline(button: h2hAwayOddsButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sportTitleLabel.frame = CGRect(x: 10,
                                       y: 0,
                                       width: 200,
                                       height: 30
        )
        
        homeTeamLabel.frame = CGRect(x: 20,
                                       y: 36,
                                       width: 180,
                                       height: 20
        )
        
        awayTeamLabel.frame = CGRect(x: 20,
                                       y: 80,
                                       width: 180,
                                       height: 20
        )
        
        commenceTimeLabel.frame = CGRect(x: 22,
                                         y: 120,
                                         width: contentView.frame.size.width - 200,
                                         height: 10
        )
        
        mlLabel.frame = CGRect(x: 222, y: 5, width: 60, height: 20)
        
        h2hHomeOddsButton.frame = CGRect(x: 210,
                                         y: 27,
                                         width: 65,
                                         height: 40
        )
        
        h2hAwayOddsButton.frame = CGRect(x: 210,
                                         y: 70,
                                         width: 65,
                                         height: 40
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func configure(with viewModel: homeTableViewCellViewModel) {
//        sportTitleLabel.text = viewModel.sport_title
        homeTeamLabel.text = viewModel.home_team
        awayTeamLabel.text = viewModel.away_team
        commenceTimeLabel.text = viewModel.commence_time
        
        mlLabel.text = "Moneyline"
        
        // Since 'markets' is an array, you might want to process it accordingly,
        // for example, you can access the first market (if available) like this:
        if viewModel.outcomes.count >= 2 {
            let homeOdds = viewModel.outcomes[0].price
            let awayOdds = viewModel.outcomes[1].price
            h2hHomeOddsButton.setTitle(String(homeOdds), for: .normal)
            h2hAwayOddsButton.setTitle(String(awayOdds), for: .normal)
        } else {
            // Handle the case when there are not enough outcomes available
            h2hHomeOddsButton.setTitle("N/A", for: .normal)
            h2hAwayOddsButton.setTitle("N/A", for: .normal)
        }

    }
}
