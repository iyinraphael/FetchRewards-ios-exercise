//
//  GeekSeatTableViewCell.swift
//  FetchRewards-ios-exercise
//
//  Created by Iyin Raphael on 2/2/21.
//

import UIKit

class GeekSeatEventTableViewCell: UITableViewCell {
    
    //  MARK: - Properties
    var eventImageView: UIImageView!
    var eventTitleLabel: UILabel!
    var eventCityLabel: UILabel!
    var datetimeLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(seatGeekEvent: GeekSeatEvent) {
     
        eventImageView = UIImageView()
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        
        eventTitleLabel = UILabel()
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTitleLabel.text = seatGeekEvent.title
        eventTitleLabel.numberOfLines = 0
        
        eventCityLabel = UILabel()
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventCityLabel.text = seatGeekEvent.venue.city
        
        datetimeLabel = UILabel()
        datetimeLabel.translatesAutoresizingMaskIntoConstraints = false
        datetimeLabel.text = seatGeekEvent.datetimeLocal
        
        addSubview(eventImageView)
        addSubview(eventTitleLabel)
        addSubview(eventCityLabel)
        addSubview(datetimeLabel)
        
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            eventImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            eventImageView.heightAnchor.constraint(equalToConstant: 100),
            eventImageView.widthAnchor.constraint(equalToConstant: 100),
            
            eventTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            eventTitleLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 5),
            eventTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            eventCityLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: 10),
            eventCityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120),
            
            datetimeLabel.topAnchor.constraint(equalTo: eventCityLabel.bottomAnchor, constant: 10),
            datetimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120)
        ])
    }
    
}
