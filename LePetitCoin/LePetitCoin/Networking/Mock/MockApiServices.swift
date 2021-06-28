//
//  MockApiServices.swift
//  LePetitCoin
//
//  Created by Maxence Chantôme on 28/06/2021.
//

import Foundation

class MockApiServices: ApiServicesType {
    
    func getList(completion: @escaping (Result<Ads, Error>) -> Void) {
        get(filename: ApiEndpoints.list.mockFilename, type: Ads.self) { response in
            completion(response)
        }
    }
    
    func getCategories(completion: @escaping (Result<Categories, Error>) -> Void) {
        get(filename: ApiEndpoints.categories.mockFilename, type: Categories.self) { response in
            completion(response)
        }
    }
    
    private func get<T: Decodable>(filename: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        // Set request duration as seconds for a better representation of a real life behavior
        let requestDuration = 1.0
    
        DispatchQueue.main.asyncAfter(deadline: .now() + requestDuration, execute: {
            if let path = Bundle.main.path(forResource: filename, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let response = try decoder.decode(type.self, from: data)
                    completion(.success(response))
                } catch let err {
                    completion(.failure(err))
                }
            } else {
                let error = NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Cant find file \(filename)"])
                completion(.failure(error))
            }
        })
    }
}
