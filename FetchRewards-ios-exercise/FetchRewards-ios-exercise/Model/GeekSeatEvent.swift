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
    let type: String
    var isFavorite: Bool?
    
    struct Performer: Codable {
        let image: String

    }
    
    struct Venue: Codable {
        let city: String
        let state: String
    }
    
    init(title: String,
         datetimeLocal: String,
         performers: [Performer],
         venue: Venue,
         type: String,
         isFavorite: Bool = false) {
        
        self.title = title
        self.datetimeLocal = datetimeLocal
        self.performers = performers
        self.venue = venue
        self.type = type
        self.isFavorite = isFavorite
    }
}

extension GeekSeatEvent.Performer: Equatable {
    
}

extension GeekSeatEvent.Venue: Equatable {
    
}

extension GeekSeatEvent: Equatable {
    
    static func == (lhs: GeekSeatEvent, rhs: GeekSeatEvent) -> Bool {
        return lhs.title == rhs.title &&
            lhs.datetimeLocal == rhs.datetimeLocal &&
            lhs.performers == rhs.performers &&
            lhs.venue == rhs.venue &&
            lhs.type == rhs.type &&
            lhs.isFavorite == rhs.isFavorite
    }
    
    
}
