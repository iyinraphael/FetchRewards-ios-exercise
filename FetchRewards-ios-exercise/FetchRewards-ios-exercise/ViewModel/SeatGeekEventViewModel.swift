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
    
    init() {
        seatGeekEventService.getEventsData { allEvent, _ in
            if let allEvent = allEvent {
                self.allEvent.value = allEvent.events
            }
        }
    }
    
    // MARK: - Methods
    
}
