//
//  SeatGeekService.swift
//  FetchRewards-ios-exercise
//
//  Created by Iyin Raphael on 2/2/21.
//

import Foundation

enum NetWorkError: Error {
    case failedRequest
    case otherError
    case noData
    case invalidResponse
    case failedDecode
}

enum CRUD: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class SeatGeekEventService {
    
    // MARK: - Properties
//    private let secretKey = "42a748abb31148f0b819684a13191ccd1c6a49abad7d61fd0ee42af324eb208e"
    private let clientId = "MjE1MjYwNTZ8MTYxMjMwNjI1NS42MzE5OTg1"
    private let path = "/2/events"
    let url = URL(string: "https://api.seatgeek.com")!
    
    typealias CompletionHandler = (AllEvents?, Result<Bool, NetWorkError>) -> Void
    
    // MARK: - Methods
    
    func getEventsData( completion: @escaping CompletionHandler = { _, _ in }) {
        var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponent?.path = path
        urlComponent?.queryItems = [ URLQueryItem(name: "client_id", value: clientId) ]
        
        guard let requestURL = urlComponent?.url else { return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = CRUD.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Failed request from SeatGeekAPI: \(error.localizedDescription)")
                completion(nil, .failure(.otherError))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from SeatGeekAPI ")
                completion(nil, .failure(.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                NSLog("Unable to process SeatGeekAPI response")
                completion(nil, .failure(.invalidResponse))
                return
            }
            
            guard response.statusCode == 200 else {
                NSLog("Failure response from SeatGeekAPI: \(response.statusCode)")
                completion(nil, .failure(.failedRequest))
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let eventData = try jsonDecoder.decode(AllEvents.self, from: data)
                print(eventData)
                
                completion(eventData, .success(true))
            } catch {
                NSLog("Unable to decode SeatGeekAPI response: \(error.localizedDescription)")
                completion(nil, .failure(.failedDecode))
            }
    
        }.resume()
        
        
    }
}
