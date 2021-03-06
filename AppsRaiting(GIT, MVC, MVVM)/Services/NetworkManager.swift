//
//  NetworkManager.swift
//  AppsRating(GIT, MVC, MVVM)
//
//  Created by Mikhail on 28.03.2021.
//

import Foundation

class NetworkManager {
    
    func request(stringUrl: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: stringUrl) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
    }
    
    func dataFetcher(stringUrl: String, completion: @escaping (_ apps: [FeedResultsApp])->()) {
        request(stringUrl: stringUrl) { (data, error) in
            let decoder = JSONDecoder()
            do {
                guard let data = data else { return }
                let response = try decoder.decode(App.self, from: data)
                completion(response.feed.results)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
