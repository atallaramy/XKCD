//
//  String+EXT.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-09-07.
//

import Foundation

extension String {
 func getCleanURL() -> URL? {
    guard !self.isEmpty  else {
        return nil
    }
    if let url = URL(string: self) {
        return url
    } else {
        if let urlEscapedString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
           let escapedURL = URL(string: urlEscapedString) {
            return escapedURL
        }
    }
    return nil
 }
}
