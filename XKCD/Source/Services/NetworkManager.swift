//
//  NetworkManager.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-15.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchCurrent(completion: @escaping (Result<Comic, XkcdError>) -> Void)
    func fetchComic(id: Int, completion: @escaping (Result<Comic, XkcdError>) -> Void)
    func fetchComicExplaination(comic: Comic, completion: @escaping (Result<Explaination, XkcdError>) -> Void)
}

class NetworkManager: NetworkServiceProtocol {
    
    private let baseURL = API.baseURL
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    ///Fetch Current
    func fetchCurrent(completion: @escaping (Result<Comic, XkcdError>) -> Void) {
        let urlString = API.currentURL
        self.loadURLAndDecode(urlString: urlString, completion: completion)
    }
    
    ///Fetch Comic
    func fetchComic(id: Int, completion: @escaping (Result<Comic, XkcdError>) -> Void) {
        let urlString = "\(API.baseURL)/\(id)\(API.URLFormat)"
        self.loadURLAndDecode(urlString: urlString, completion: completion)
    }
    
    /// FetchExplaination
    func fetchComicExplaination(comic: Comic, completion: @escaping (Result<Explaination, XkcdError>) -> Void) {
        let urlString = "\(API.explainationURL)\(comic.num):_\(comic.title)\(API.explainationURLFormat)"
        self.loadURLAndDecode(urlString: urlString, completion: completion)
    }
    
    /// Fetching Generic Method
    private func loadURLAndDecode<D: Decodable>(urlString: String, completion: @escaping (Result<D, XkcdError>) -> Void) {
        guard let url = urlString.getCleanURL() else {
            completion(.failure(.invalidEndPoint))
            return
        }
        print("DEBUG: urlstring is \(urlString)")
        
        urlSession.dataTask(with: url) { [weak self] data, response, err in
            guard let self = self else { return }
            
            if err != nil {
                self.completionHandlerOnMainThrea(with: .failure(.invalidEndPoint), completion: completion)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                self.completionHandlerOnMainThrea(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.completionHandlerOnMainThrea(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.completionHandlerOnMainThrea(with: .success(decodedResponse), completion: completion)
            } catch {
                self.completionHandlerOnMainThrea(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func completionHandlerOnMainThrea<D: Decodable>(with result: Result<D, XkcdError>, completion: @escaping (Result<D, XkcdError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}




