//
//  NetworkManager.swift
//  XKCD
//
//  Created by Ramy Atalla on 2022-03-15.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchCurrent(completion: @escaping (Result<Comic, XkcdError>) -> Void)
    func fetchComid(id: Int, completion: @escaping (Result<Comic, XkcdError>) -> Void)
}

class NetworkManager: NetworkServiceProtocol {
    
    private let baseURL = API.baseURL
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utils.jsonDecoder
    
    ///Fetch Current
    func fetchCurrent(completion: @escaping (Result<Comic, XkcdError>) -> Void) {

        guard let url = URL(string: API.currentURL) else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    ///Fetch Comic
    func fetchComid(id: Int, completion: @escaping (Result<Comic, XkcdError>) -> Void) {
        let fullURL = "\(API.baseURL)/\(id)\(API.URLFormat)"
        guard let url = URL(string: fullURL) else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    
    /// Fetching Generic Method
    private func loadURLAndDecode<D: Decodable>(url: URL, parameters: [String: String]? = nil, completion: @escaping (Result<D, XkcdError>) -> Void) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndPoint))
            return
        }

        var queryItems = [URLQueryItem]()
        if let parameters = parameters {
            queryItems.append(contentsOf: parameters.map { URLQueryItem(name: $0.key, value: $0.value)})
        }
        urlComponents.queryItems = queryItems

        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndPoint))
            return
        }
        print("DEBUG: final url \(finalURL)")
        urlSession.dataTask(with: finalURL) { [weak self] data, response, err in
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
                print("DEBUG: \(String(describing: data))")
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

    
    

