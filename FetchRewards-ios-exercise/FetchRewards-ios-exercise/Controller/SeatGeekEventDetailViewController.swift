//
//  SeatGeekEventDetailViewController.swift
//  FetchRewards-ios-exercise
//
//  Created by Iyin Raphael on 2/4/21.
//

import UIKit

class SeatGeekEventDetailViewController: UIViewController {
    
    //MARK: -Properties
    var seatGeekEvent: GeekSeatEvent?
    var allEvents: [GeekSeatEvent]?
    var favoriteButton: UIButton!
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM YYY HH:mm a"
        return dateFormatter
    }()
    
    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic

        if let seatGeekEvent = seatGeekEvent {
            
            favoriteButton = UIButton()
            favoriteButton.translatesAutoresizingMaskIntoConstraints = false
            favoriteButton.addTarget(self, action: #selector(isFavorite), for: .touchUpInside)
            favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
            favoriteButton.tintColor = .black
            favoriteButton.isUserInteractionEnabled = true
            
            let eventTitleLabel = UILabel()
            eventTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            eventTitleLabel.text = seatGeekEvent.title
            eventTitleLabel.numberOfLines = 0
            eventTitleLabel.adjustsFontSizeToFitWidth = true
            eventTitleLabel.font = .boldSystemFont(ofSize: 20)
            
            let imageView = UIImageView()
            imageView.loadImageUsingCache(withUrl: seatGeekEvent.performers[0].image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 5
            
            let dateLabel = UILabel()
            dateLabel.translatesAutoresizingMaskIntoConstraints = false
            dateLabel.text = seatGeekEvent.datetimeLocal
            let date = dateFormatter.date(from: seatGeekEvent.datetimeLocal)
            dateLabel.text = dateFormatter.string(from: date ?? Date())
            dateLabel.font = .boldSystemFont(ofSize: 18)
            
            let cityLabel = UILabel()
            cityLabel.translatesAutoresizingMaskIntoConstraints = false
            cityLabel.text = "\(seatGeekEvent.venue.city), \(seatGeekEvent.venue.state)"
            cityLabel.font = .systemFont(ofSize: 15)
            cityLabel.textColor = .gray
            
            view.addSubview(favoriteButton)
            view.addSubview(eventTitleLabel)
            view.addSubview(imageView)
            view.addSubview(dateLabel)
            view.addSubview(cityLabel)
            
            NSLayoutConstraint.activate([
                favoriteButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                
                eventTitleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                eventTitleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10),
                eventTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                
                imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 80),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                imageView.heightAnchor.constraint(equalToConstant: 250),
                
                dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
                dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
                
                cityLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
                cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            ])
            
        }
    
    }
    
    // MARK: - Methods
    @objc func isFavorite() {
        guard let isFavorite = seatGeekEvent?.isFavorite  else { return }
        
        seatGeekEvent!.isFavorite = !isFavorite
        
        if seatGeekEvent!.isFavorite == true {
            favoriteButton.setImage(UIImage(named: "favorite.red"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
        }
    }
}
