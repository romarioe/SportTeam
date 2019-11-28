//
//  NetworkService.swift
//  AnimateTest
//
//  Created by Roman Efimov on 22/10/2019.
//  Copyright © 2019 Roman Efimov. All rights reserved.
//

import Foundation

class NetworkService{

    let playersUrl = URL(string: "http://romarioe.tk/api/routes/players.php")
    
    func fetchPlayers(completion: @escaping (Result<Data, Error>) -> Void){
        URLSession.shared.dataTask(with: playersUrl!) { (data, _, error) in
             DispatchQueue.main.async {
                           if let error = error {
                               completion(.failure(error))
                               return
                           }
                           guard let data = data else { return }
                           completion(.success(data))
            }
        }.resume()
    }
    
    

    
    private func prepareNewsURL(params: [String: String]) -> URL {
        var newsURL = URLComponents()
        newsURL.scheme = "https"
        newsURL.host = "api.vk.com"
        newsURL.path = "/method/wall.get"
        newsURL.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return newsURL.url!
    }
    
    
    
    private func prepareNewsParaments() -> [String: String] {
        var parameters = [String: String]()
        parameters["v"] = "5.25"
        parameters["filter"] = "owner"
        parameters["domain"] = "hc_adyif_official"
        parameters["count"] = "10"
        parameters["access_token"] = "3e9cd2f43e9cd2f43e9cd2f4a03ef14ad233e9c3e9cd2f4632d8ac3ed4f8cd026772d6f"
        return parameters
    }
    
    
    func fetchNews(completion: @escaping (Result<Data, Error>) -> Void){
        let parametrs = prepareNewsParaments()
        let newsURL = prepareNewsURL(params: parametrs)
        
       // let newsURL = URL(string: "https://api.vk.com/method/wall.get?v=5.25&filter=owner&domain=hc_adyif_official&count=10&access_token=3e9cd2f43e9cd2f43e9cd2f4a03ef14ad233e9c3e9cd2f4632d8ac3ed4f8cd026772d6f")
        
        URLSession.shared.dataTask(with: newsURL) { (data, _, error) in
             DispatchQueue.main.async {
                           if let error = error {
                               print ("Error")
                               completion(.failure(error))
                               return
                           }
                           guard let data = data else { return }
                            print ("Success")
                           completion(.success(data))
            }
        }.resume()
    }
    
    
    
    
}

