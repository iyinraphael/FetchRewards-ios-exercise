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
    var eventCityAndStateLabel: UILabel!
    var datetimeLabel: UILabel!
    var cellView: UIView!
    var cellContentView: UIView!
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM YYY \nHH:mm a"
        return dateFormatter
    }()
    
    var seatGeekEvent: GeekSeatEvent?{
        didSet{
            configureCell()
        }
    }
    
    override func prepareForReuse() {
        cellContentView = nil
        cellView = nil
        eventImageView = nil
        eventTitleLabel = nil
        eventCityAndStateLabel = nil
        datetimeLabel = nil
    }
    
    func configureCell() {
        
        cellContentView = UIView()
        cellContentView.translatesAutoresizingMaskIntoConstraints = false
        cellContentView.backgroundColor = .white
        addSubview(cellContentView)
        
        cellView = UIView()
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.layer.frame = contentView.bounds
        cellView.backgroundColor = .white
        cellView.layer.backgroundColor = UIColor.white.cgColor
        cellView.layer.contentsGravity = .center
        cellView.layer.magnificationFilter = .linear
        cellView.layer.cornerRadius = 10.0
        cellView.layer.borderWidth = 0.1
        cellView.layer.borderColor = UIColor.white.cgColor
        cellView.layer.shadowOpacity = 0.4
        cellView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cellView.layer.shadowRadius = 3.0
        cellView.layer.isGeometryFlipped = false
       cellContentView.addSubview(cellView)
        
        eventImageView = UIImageView()
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.layer.cornerRadius = 10
        eventImageView.clipsToBounds = true
        
        eventTitleLabel = UILabel()
        eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventTitleLabel.text = seatGeekEvent?.title
        eventTitleLabel.numberOfLines = 0
        eventTitleLabel.font = .boldSystemFont(ofSize: 18)
        
        eventCityAndStateLabel = UILabel()
        eventCityAndStateLabel.translatesAutoresizingMaskIntoConstraints = false
        let cityAndState = "\(seatGeekEvent?.venue.city ?? ""), \(seatGeekEvent?.venue.state ?? "")"
        eventCityAndStateLabel.text = cityAndState
        eventCityAndStateLabel.font = .systemFont(ofSize: 15)
        eventCityAndStateLabel.textColor = .gray
        
        datetimeLabel = UILabel()
        datetimeLabel.translatesAutoresizingMaskIntoConstraints = false
        datetimeLabel.font = .systemFont(ofSize: 15)
        datetimeLabel.textColor = .gray
        datetimeLabel.numberOfLines = 0
        let date = dateFormatter.date(from: seatGeekEvent?.datetimeLocal ?? "")
        datetimeLabel.text = dateFormatter.string(from: date ?? Date())
        
        
        cellView.addSubview(eventImageView)
        cellView.addSubview(eventTitleLabel)
        cellView.addSubview(eventCityAndStateLabel)
        cellView.addSubview(datetimeLabel)
        
        NSLayoutConstraint.activate([
            cellContentView.topAnchor.constraint(equalTo: topAnchor),
            cellContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cellView.topAnchor.constraint(equalTo: cellContentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor, constant: 10),
            cellView.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor, constant: -10),
            cellView.bottomAnchor.constraint(equalTo: cellContentView.bottomAnchor, constant: -10),
            
            eventImageView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            eventImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            eventImageView.heightAnchor.constraint(equalToConstant: 75),
            eventImageView.widthAnchor.constraint(equalToConstant: 75),
            
            eventTitleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            eventTitleLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
            eventTitleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            
            eventCityAndStateLabel.topAnchor.constraint(equalTo: eventTitleLabel.bottomAnchor, constant: 10),
            eventCityAndStateLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
            eventCityAndStateLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            
            datetimeLabel.topAnchor.constraint(equalTo: eventCityAndStateLabel.bottomAnchor, constant: 10),
            datetimeLabel.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 10),
            datetimeLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            datetimeLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10)
        ])
    }
    
}
