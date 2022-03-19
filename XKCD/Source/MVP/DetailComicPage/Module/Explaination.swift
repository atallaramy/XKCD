//
//  Explaination.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-18.
//

import Foundation

// MARK: - Explaination
struct Explaination: Codable {
    let parse: Parse?
}

// MARK: - Parse
struct Parse: Codable {
    let title: String?
    let pageid: Int?
    let wikitext: Wikitext
}

// MARK: - Wikitext
struct Wikitext: Codable {
    let explaination: String?

    enum CodingKeys: String, CodingKey {
        case explaination = "*"
    }
}
