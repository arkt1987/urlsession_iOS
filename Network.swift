//
//  Network.swift
//  testApp
//
//  Created by SAIL on 22/06/23.
//

import Foundation
import UIKit

typealias JSON = [String:Any]

class APIHandler {
    
    public static var shared: APIHandler = APIHandler()
    
    private init(){}

}

extension APIHandler {
    func getLoginDetails<T: Decodable>(type: T.Type, endpoint: String, param: JSON, completion: @escaping(Result<T, Error>) -> Void) {
        
        var originalUrl = endpoint
        print("::::::: Get Original Url --> \(originalUrl)")
        
        let paramStr = param.compactMap({ "\($0.key)=\($0.value)" }).joined(separator: "&")
        print("::::::: Get ParamStr --> \(paramStr)")
        
        guard let url = URL(string: originalUrl) else { return }
        
        let urlReq = URLRequest(url: url)
        
        print("::::::: Function Starts here ::::::::::")
        
        URLSession.shared.dataTask(with: urlReq) { data, urlResponse, error in
            print("::::::: Function * API * Starts here ::::::::::")
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let model = try decoder.decode(type, from: data)
                    completion(.success(model))
                }
                catch {
                    completion(.failure(error))
                }
            }
            
        }.resume()
     
    }
}
