//
//  SeatGeekViewController.swift
//  FetchRewards-ios-exercise
//
//  Created by Iyin Raphael on 2/2/21.
//

import UIKit

class SeatGeekViewController: UIViewController {

    //MARK: - Properties
    let reuseIdentifier = "eventCell"
    var tableView: UITableView!
    let seatGeekEventViewModel = SeatgeekViewModel()
    var allEvents = [GeekSeatEvent]()
   
    //MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GeekSeatEventTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        seatGeekEventViewModel.allEvent.bind { [weak self] allEvents in
            if let allEvents = allEvents {
                self?.allEvents = allEvents
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

    // MARK: - UITableView DataSource
extension SeatGeekViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? GeekSeatEventTableViewCell
        else { return UITableViewCell() }
        
        let seatGeekEvent = allEvents[indexPath.row]
        cell.seatGeekEvent = seatGeekEvent
        cell.eventImageView.loadImageUsingCache(withUrl: seatGeekEvent.performers[0].image)
        
        return cell
    }
    
}
