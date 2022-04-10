//
//  ExchangeServices.swift
//  Le Baluchon
//
//  Created by Dusan Orescanin on 28/03/2022.
//

import Foundation

// ExchangeService
class ExchangeService {
    static let shared = ExchangeService()
    
    private static let exchangeUrl = URL(string: "http://data.fixer.io/api/latest?access_key=8fa6e5cbc35b78daa378666782724a7f")!
    
    private var task: URLSessionDataTask?
    
    private var session = URLSession(configuration: .default)
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // GetExchange
    func getExchange(completion: @escaping (_ result: ExchangeResponse?) -> Void) {
        
        var request = URLRequest(url: ExchangeService.exchangeUrl)
        request.httpMethod = "Get"
        
        task = session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                guard let data = data, error == nil else {
                    completion(.none)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.none)
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode(ExchangeResponse.self, from: data) else {
                    completion(.none)
                    return
                }
                
                completion(.some(responseJSON))
                print(responseJSON)
            }
        }
        task?.resume()
    }
}
