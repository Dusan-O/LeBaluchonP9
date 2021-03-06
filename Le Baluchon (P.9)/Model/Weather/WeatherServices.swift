//
//  WeatherServices.swift
//  Le Baluchon
//
//  Created by Dusan Orescanin on 28/03/2022.
//

import Foundation

class WeatherServices {
    
    static let shared = WeatherServices()
    
    private var task: URLSessionDataTask?
    
    private var session = URLSession(configuration: .default)
    init(session: URLSession = .shared) {
        self.session = session
    }
    // GetWeather
    func getWeather(urlString: String, completion: @escaping (_ result: WeatherResponse?) -> Void) {
        
        let url = URL(string: urlString)!
        
        let request = URLRequest(url: url)
        
        task = session.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                guard let data = data, error == nil else {
                    completion(.none)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.none)
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(WeatherResponse.self, from: data) else {
                    completion(.none)
                    return
                }
                completion(.some(responseJSON))
            }
        }
        task?.resume()
    }
}
