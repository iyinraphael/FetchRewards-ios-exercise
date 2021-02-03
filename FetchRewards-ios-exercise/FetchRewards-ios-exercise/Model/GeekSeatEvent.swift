//
//  GeekSeatEvent.swift
//  FetchRewards-ios-exercise
//
//  Created by Iyin Raphael on 2/2/21.
//

import Foundation

struct GeekSeatEvent: Codable {
    let title: String
    let datetimeLocal: String
    let performers: [Performer]
    let venue: Venue
    
    struct Performer: Codable {
        let image: String
    }
    
    struct Venue: Codable {
        let city: String
    }
}

