//
//  NetworkFetcher.swift
//  AnimateTest
//
//  Created by Roman Efimov on 22/10/2019.
//  Copyright © 2019 Roman Efimov. All rights reserved.
//

import Foundation
import UIKit

class NetworkPlayersFetcher {
    
    let networkService = NetworkService()
    
    func fetchPlayers(response: @escaping (SearchResponse?) -> Void) {
        networkService.fetchPlayers { (result) in

            switch result {
            case .success(let data):
                do {
                    let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                    response(searchResponse)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
    
    
    
    func fetchImage(url: URL?, completion: @escaping (UIImage?) -> Void){
        guard let url = url else {
            completion(nil)
            return
            
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
                
            }
            
            guard let image = UIImage(data: data) else {return}
            completion(image)
            
            }.resume()
   
    }
    
    
    
}

