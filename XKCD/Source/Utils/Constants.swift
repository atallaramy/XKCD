//
//  Constants.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-15.
//

import Foundation
import CoreVideo

enum API {
    static let currentURL = "https://xkcd.com/info.0.json"
    static let baseURL = "https://xkcd.com"
    static let URLFormat = "/info.0.json"
    static let explainationURL = "https://www.explainxkcd.com/wiki/api.php?action=parse&page="
    static let explainationURLFormat = "&prop=wikitext&sectiontitle=Explanation&format=json"
}

enum XkcdError: Error, CustomNSError {
    init(rawValue: String) {
        switch rawValue {
        case "testFail": self = .apiError
        default: self = .apiError
        }
    }
    case apiError
    case invalidEndPoint
    case invalidResponse
    case noData
    case serializationError
    case unsupportedImage
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndPoint: return "Invalid endpoing"
        case .invalidResponse: return "Invalid https response"
        case .noData: return "No Data found"
        case .serializationError: return "Unable to decode data"
        case .unsupportedImage: return "the data loaded has unsupported image"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}

enum Alerts {
    case newestComic
    case oldestComic
    
    var alertTitle: String {
        switch self {
        case .newestComic: return "No more"
        case .oldestComic: return "No more"
        }
    }
    
    var alertMessage: String {
        switch self {
        case .newestComic: return "This was newest Comic already"
        case .oldestComic: return "This is the first comic already"
        }
    }
}

enum K {
    case explainationNil
    
    var message: String {
        switch self {
        case .explainationNil: return "No explaination implemented, help us to edit it"
        }
    }
}
