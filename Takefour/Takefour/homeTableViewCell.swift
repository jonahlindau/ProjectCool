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
    
    init(
        sport_title: String,
        home_team: String,
        away_team: String,
        commence_time: String
    ) {
        self.sport_title = sport_title
        self.home_team = home_team
        self.away_team = away_team
        self.commence_time = commence_time
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
        label.font = .systemFont(ofSize: 23, weight: .regular)
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
