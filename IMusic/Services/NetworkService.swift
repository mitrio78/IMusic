//
//  NetworkService.swift
//  IMusic
//
//  Created by Mitrio on 04.04.2022.
//

import UIKit
import Alamofire

class NetworkService {
    
    func fetchTracks(searchText: String, completion: @escaping (SearchResponse?) -> Void) {
        let url = "https://itunes.apple.com/search"
        let params = [
            "term":"\(searchText)",
            "limit": "10",
            "media":"music"
        ]
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = dataResponse.data else {
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let objects = try decoder.decode(SearchResponse.self, from: data)
                print("objects:", objects)
                completion(objects)
            } catch let jsonError {
                print("Failed decode JSON, \(jsonError.localizedDescription)")
                completion(nil)
            }
        }
    }
}
