//
//  SeatEventViewController.swift
//  FetchRewards-ios-exercise
//
//  Created by Iyin Raphael on 2/4/21.
//

import UIKit

class SeatEventViewController: UIViewController {
    
    // MARK: - Properties
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var seatGeekEventViewModel: SeatgeekViewModel?
    let reuseIdentifier = "eventCell"
    let barTintColor = UIColor(red: 20/255, green: 39/255, blue: 89/255, alpha: 1)
    var allEvents = [GeekSeatEvent]()

    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search Event"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.barTintColor = barTintColor
        navigationController?.navigationBar.tintColor = barTintColor
//        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        
        seatGeekEventViewModel?.allEvent.bind { [weak self] allEvents in
            if let allEvents = allEvents {
                self?.allEvents = allEvents
            }
        }
        
        seatGeekEventViewModel?.tableView.bind { [weak self] tableView  in
            
            if let self = self {
                if let tableView = tableView {
                    self.tableView = tableView
                    self.tableView.translatesAutoresizingMaskIntoConstraints = false
                    self.tableView.dataSource = self
                    self.tableView.delegate = self
                    self.tableView.separatorStyle = .none
                    self.tableView.showsVerticalScrollIndicator = false
                    self.view.addSubview(tableView)
                    
                    tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                    tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
                    tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
                    tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                }
            }
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tableView = tableView {
            tableView.reloadData()
        }
    }

}

    // MARK: - UITableView DataSource
extension SeatEventViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allEvents.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as?
                GeekSeatEventTableViewCell else { return UITableViewCell() }
        
        let seatGeekEvent = allEvents[indexPath.row]
        cell.seatGeekEvent = seatGeekEvent
        cell.eventImageView.loadImageUsingCache(withUrl: seatGeekEvent.performers[0].image)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let seatGeekEvent = allEvents[indexPath.row]
        let vc = SeatGeekEventDetailViewController()
        vc.seatGeekEvent = seatGeekEvent
        vc.viewModel = seatGeekEventViewModel
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension SeatEventViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let type = searchText.lowercased()
        seatGeekEventViewModel?.searchForEventWith(type: type)
        guard let allEventFiltered =  seatGeekEventViewModel?.filteredEvents else { return }
        self.allEvents =  allEventFiltered
        self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.tableView.reloadData()
    }
}
