//
//  TranslatorServices.swift
//  Le Baluchon
//
//  Created by Dusan Orescanin on 28/03/2022.
//

import Foundation

class TranslateService {

    static let shared = TranslateService()
    
    private var task: URLSessionDataTask?
    
    private var session = URLSession(configuration: .default)
    init(session: URLSession = .shared) {
        self.session = session
    }
    // GetTranslation
    func getTranslation(for text: String, target: String, source: String, completion: @escaping (_ result: TranslationResponse?) -> Void){
        
        let request = createTranslateRequest(text: text, target: target, source: source)
        
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
                
                guard let responseJSON = try? JSONDecoder().decode(TranslationResponse.self, from: data) else {
                    completion(.none)
                    return
                }
                completion(.some(responseJSON))
                
            }
        }
        task?.resume()
    }
    // CreateTranslateRequest
    private func createTranslateRequest(text: String, target: String, source: String) -> URLRequest {
        let baseURLString = "https://translation.googleapis.com/language/translate/v2"
        var components = URLComponents(string: baseURLString)!
        let urlParams = ["q": text, "target": target, "format": "text", "source": source, "model": "base", "key": "AIzaSyCg0w8C-0jkiJrczgul2LJNXPa79FtS8hE"]
        
        components.queryItems = urlParams.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
        
        var request = URLRequest(url: URL(string: baseURLString)!)
        
        request.url = components.url
        
        request.httpMethod = "POST"
        request.setValue("application/Json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
