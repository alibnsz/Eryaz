//
//  DownloaderClient.swift
//  Eryaz
//
//  Created by Mehmet Ali Bunsuz on 6.08.2024.
//

import Foundation

protocol APIService {
    func fetchData(completion: @escaping (Result<Model, Error>) -> Void)
}

class APIServiceImpl: APIService {
    private let urlString = "https://raw.githubusercontent.com/alibnsz/test/main/data.json"
    
    func fetchData(completion: @escaping (Result<Model, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            do {
                let model = try JSONDecoder().decode(Model.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

