//
//  WebService.swift
//  YIT
//
//  Created by Neria Jerafi on 26/04/2021.
//

import Foundation
import Alamofire

enum WebServiceError:Error{
    case failure
}

struct WebService{
    
    static func getRequest<T:Decodable>(stringUrl: String = "https://pixabay.com/api/?q=cat&key=6814610-cd083c066ad38bb511337fb2b&per_page=50",CompletionHandler: @escaping(Result<T,WebServiceError>)->())  {
        guard let url = URL(string:stringUrl) else {return}
        AF.request(url,method: .get).responseData { (response) in
            if let responseData = response.data{
                do{
                    let data = try JSONDecoder().decode(T.self, from: responseData)
                    CompletionHandler(.success(data))
                }catch{
                    CompletionHandler(.failure(.failure))
                }
            }else{
                CompletionHandler(.failure(.failure))
            }
        }
    }
}
