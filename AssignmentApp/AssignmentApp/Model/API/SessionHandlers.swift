//
//  SessionHandler.swift
//  AssignmentApp
//
//  Created by Blessy Saini on 6/23/21.
//

import Foundation
import Reachability


typealias Closure = (_ result: ApiResponse) -> () // service call completion closure
typealias JSON = [String: Any]


//MARK: API Response Sharing
struct ApiResponse {
    let status: Bool
    let response: Any?
}


enum httpMethods: String{
    case post = "post"
    case get = "get"
    case delete = "delete"
    case put = "put"
    
    var values: String{
        return self.rawValue
    }
}


//MARK: - Network API Call


class SessionHandlers: NSObject {
    
    class func sessionHandler(url: URL, parameters: [String: Any]?,method: httpMethods, closure : @escaping Closure){
                 
            
            var serviceRequest = URLRequest(url: url)
            serviceRequest.httpMethod = method.values.uppercased()
          
            let header = ["Accept":"application/json",
                          "Content-Type":"application/json"]
            
            serviceRequest.allHTTPHeaderFields = header
            
            if method == .post || method == .put {
                
                if let params = parameters{
                    print("Parameters:", params)
                    
                    if let jsonDatas = try? JSONSerialization.data(withJSONObject: params as Any, options: JSONSerialization.WritingOptions.prettyPrinted){
                        serviceRequest.httpBody = jsonDatas
                    }
                }
            }
            
            URLSession.shared.dataTask(with: serviceRequest as URLRequest, completionHandler: { (data, response, error) -> Void in

                guard let serviceData = data, error == nil else{
                    DispatchQueue.main.async {
                        closure(ApiResponse(status: false, response: nil))
                    }
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse{
                    
                    DispatchQueue.main.async {
                    }
                    if  httpStatus.statusCode >= 200 && httpStatus.statusCode <= 206 {
                        closure(ApiResponse(status: true, response: serviceData))
                        
                    }else{
                        closure(ApiResponse(status: false, response: nil))
                    }
                }
                return
            }).resume()
            
        
    }
}
