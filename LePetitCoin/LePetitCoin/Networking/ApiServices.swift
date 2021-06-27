//
//  ApiServices.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 24/06/2021.
//

import Foundation

protocol ApiServicesType {
    func getList(completion: @escaping (Result<Ads, Error>) -> Void)
    func getCategories(completion: @escaping (Result<Categories, Error>) -> Void)
}

class ApiServices: ApiServicesType {
    private let baseUrl = "raw.githubusercontent.com"
    
    func getList(completion: @escaping (Result<Ads, Error>) -> Void) {
        get(endpoint: .list, type: Ads.self) { result in
            completion(result)
        }
    }
    
    func getCategories(completion: @escaping (Result<Categories, Error>) -> Void) {
        get(endpoint: .categories, type: Categories.self) { result in
            completion(result)
        }
    }
    
    private func get<T: Decodable>(endpoint: ApiEndpoints, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let url = URL(string: "https://\(baseUrl)\(endpoint.path)")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let gitData = try decoder.decode(type.self, from: data)
                completion(.success(gitData))
            } catch let err {
                completion(.failure(err))
            }
        }
        
        task.resume()
    }
}
