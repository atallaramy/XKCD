//
//  Constants.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-15.
//

import Foundation

enum API {
    static let currentURL = "https://xkcd.com/info.0.json"
    static let baseURL = "https://xkcd.com"
    static let URLFormat = "/info.0.json"
}

enum XkcdError: Error, CustomNSError {
    case apiError
    case invalidEndPoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndPoint: return "Invalid endpoing"
        case .invalidResponse: return "Invalid https response"
        case .noData: return "No Data found"
        case .serializationError: return "Unable to decode data"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
    
}
