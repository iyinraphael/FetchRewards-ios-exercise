//
//  SeatGeekEventViewModel.swift
//  FetchRewards-ios-exercise
//
//  Created by Iyin Raphael on 2/2/21.
//

import UIKit.UIImage

class SeatgeekViewModel {

    // MARK: - Properties
    var allEvent: Observable<[GeekSeatEvent]?> = Observable(nil)
    let seatGeekEventService = SeatGeekEventService()
    var filteredEvents = [GeekSeatEvent]()
    let reuseIdentifier = "eventCell"
    var tableView: Observable<UITableView?> = Observable(nil)
    
    init() {
        seatGeekEventService.getEventsData { [weak self] allEvent, _ in
            if let self = self {
                if let allEvent = allEvent {
                    self.allEvent.value = allEvent.events.map {
                        GeekSeatEvent(title: $0.title,
                                      datetimeLocal: $0.datetimeLocal,
                                      performers: $0.performers,
                                      venue: $0.venue,
                                      type: $0.type)
                    }
                   
                    DispatchQueue.main.async {
                        self.tableView.value = UITableView()
                        self.tableView.value?.register(GeekSeatEventTableViewCell.self,
                                                       forCellReuseIdentifier: self.reuseIdentifier)
                        self.tableView.value?.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: - Methods
    func searchForEventWith(type: String) {
        guard let allEvent = allEvent.value else { return }
        filteredEvents = allEvent.filter{ $0.type == type}
    }
    
    func update(seatGeekEvent: GeekSeatEvent, with favorite: Bool) {
        let geekSeatEvent = GeekSeatEvent(title: seatGeekEvent.title,
                                          datetimeLocal: seatGeekEvent.datetimeLocal,
                                          performers: seatGeekEvent.performers,
                                          venue: seatGeekEvent.venue,
                                          type: seatGeekEvent.type,
                                          isFavorite: favorite)
        
        guard let index = allEvent.value?.firstIndex(of: seatGeekEvent) else { return }
        allEvent.value?.remove(at: index)
        allEvent.value?.insert(geekSeatEvent, at: index)
        
    }
}

