//
//  HackathonAPI.swift
//  Hackaton
//
//  Created by Robson Fernandes on 17/03/18.
//  Copyright © 2018 Robson Fernandes. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class HackathonAPI {
    
    lazy var requestingObserver = PublishSubject<Bool>()
    
    func headers() -> [String: String]? {
        return nil
    }
    
    func requestData(endpoint: String, method: HTTPMethod = .get, dictionary: [String: Any]? = nil, completion: @escaping (Data?, HackathonAPIError?) -> Void) {
        let url = "\(AppConfig.baseEndpoint)\(endpoint)"
        print(url)
        print(dictionary ?? "") 
        
        let aRequest = Alamofire.request(url, method: method, parameters: dictionary, encoding: JSONEncoding.default, headers: headers())
        
        requestingObserver.onNext(true)
        aRequest.responseData { response in
            self.requestingObserver.onNext(false)
            do {
                switch response.result {
                case .success(let data):
                    if response.response?.statusCode ?? 200 >= 400 {
                        // Error
                        let error = try JSONDecoder().decode(HackathonErrorModel.self, from: data)
                        completion(nil, .error(error.error))
                    }
                    else {
                        // Response OK. Process
                        completion(data, nil)
                    }
                case .failure(let error):
                    completion(nil, .error(error.localizedDescription))
                    break
                }
            }
            catch {
                completion(nil, .error("Inespecific Error"))
            }
        }
    }
    
    func requestFrom<R: Decodable>(endpoint: String, method: HTTPMethod = .get, dictionary: [String: Any]? = nil, completion: @escaping (R?, HackathonAPIError?) -> Void) {
        
        requestData(endpoint: endpoint, method: method, dictionary: dictionary) { (data, error) in
            if let error = error {
                completion(nil, error)
            }
            else if let data = data {
                do {
                    if R.self == String.self {
                        let value = String(data: data, encoding: .utf8)
                        completion(value as? R, nil)
                    }
                    else {
                        completion(try JSONDecoder().decode(R.self, from: data), nil)
                    }
                }
                catch {
                   completion(nil, .error("Inespecific Error"))
                }
            }
        }
    }
    
    func request<T: HackathonRequestProtocol, R: Decodable>(_ request: T, method: HTTPMethod = .get, completion: @escaping (R?, HackathonAPIError?) -> Void) {
        
        do {
            let data = try JSONEncoder().encode(request)
            if let dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any] {
                requestFrom(endpoint: request.endpoint(), method: method, dictionary: dictionary, completion: completion)
            }
        }
        catch {
            completion(nil, .error("Inespecific Error"))
        }
    }
    
}
