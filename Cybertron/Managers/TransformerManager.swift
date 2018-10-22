//
//  TransformerManager.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-19.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import Moya

typealias TransformerListHandler = ((_ list: [Transformer], _ error: Error?) -> Void)
typealias TransformerHandler = ((_ transformer: Transformer?, _ error: Error?) -> Void)
typealias SuccessHandler = ((_ success: Bool, _ error: Error?) -> Void)
typealias TokenHandler = ((_ token: String?, _ error: Error?) -> Void)

/// Deals with requests for Transformer CRUD
class TransformerManager {
    
    /// Moya provider
    var provider = MoyaProvider<TransformerService>()

    /// Token from UserDefaults. Nil if none
    var token: String? {
        return UserDefaults.standard.string(forKey: Const.UserDefaultKeys.tokenKey)
    }
    
    /**
     Initializes a TransformerManager with deals with requests
     ```
     Checks if token is accessible and creates a new Moya Provider passing the token.
     ```
     */
    init() {
        if let token = token {
            let authPlugin = AccessTokenPlugin(tokenClosure: token)
            provider = MoyaProvider<TransformerService>(plugins: [authPlugin])
        }
    }
    
    /**
     Retrieves a Token
     ```
     After retrieving a token, saves it using NSDefaults.
     Don't make the request if token is already saved.
     ```
     - parameter completion: TokenHandler?
     - returns: void
     */
    private func retrieveToken(_ completion: TokenHandler?) {
        print(#function)
        if token != nil {
            print("yay we have the token already")
            completion?(token, nil)
            return
        }
        
        provider.request(.allSpark) { [weak self] result in
            print("Response of allSpark")
            switch result {
            case let .success(moyaResponse):
                print(moyaResponse)
                
                switch moyaResponse.statusCode { // Int - 200, 401, 500, etc
                case 200..<300:
                    guard let newToken = String(data: moyaResponse.data, encoding: .utf8) else {
                        UserDefaults.standard.set(nil, forKey: Const.UserDefaultKeys.tokenKey)
                        completion?(nil, MyError.failToken)
                        return
                    }
                    
                    UserDefaults.standard.set(newToken, forKey: Const.UserDefaultKeys.tokenKey)
                    
                    let authPlugin = AccessTokenPlugin(tokenClosure: newToken)
                    self?.provider = MoyaProvider<TransformerService>(plugins: [authPlugin])
                    
                    completion?(newToken, nil)
                default:
                    completion?(nil, MyError.unknown)
                }
                
            case let .failure(error):
                print(error.localizedDescription)
                UserDefaults.standard.set(nil, forKey: Const.UserDefaultKeys.tokenKey)
                completion?(nil, error)
            }
        }
    }
    
    /**
     Fetch all transformers from a token
     ```
     First check if we have the token calling retrieveToken method
     
     ```
     - parameter completion: TransformerListHandler?
     - returns: void
     */
    func fetchAll(_ completion: @escaping TransformerListHandler) {
        print(#function)
        
        retrieveToken { [weak self] (_, _) in
            self?.provider.request(.transformers) { (result) in
                switch result {
                case let .success(moyaResponse):
                    print(moyaResponse.statusCode)

                    switch moyaResponse.statusCode { // Int - 200, 401, 500, etc
                    case 200..<300:
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let transformers = try? decoder.decode([String: [Transformer]].self, from: moyaResponse.data)
                        completion(transformers?["transformers"] ?? [], nil)
                    default:
                        completion([], MyError.unknown)
                    }
                    
                case let .failure(error):
                    print(error.localizedDescription)
                    completion([], error)
                }
            }
        }
    }
    
    /**
     Creates a new transformer
     ```
     First check if we have the token calling retrieveToken method
     
     ```
     - parameter transformer: Transformer
     - parameter completion: TransformerHandler?
     - returns: void
     */
    func create(transformer: Transformer, _ completion: @escaping TransformerHandler) {
        print(#function)
        
        retrieveToken { [weak self] (_, _) in
            self?.provider.request(.create(transformer: transformer)) { (result) in
                switch result {
                case let .success(moyaResponse):
                    print(moyaResponse.statusCode)
                    
                    switch moyaResponse.statusCode { // Int - 200, 401, 500, etc
                    case 200..<300:
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let transformer = try? decoder.decode(Transformer.self, from: moyaResponse.data)
                        
                        completion(transformer, nil)
                    default:
                        completion(nil, MyError.unknown)
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
        }
    }
    
    /**
     Updates a transformer
     ```
     First check if we have the token calling retrieveToken method.
     We need to have at least the id of the transformer
     
     ```
     - parameter transformer: Transformer
     - parameter completion: TransformerHandler?
     - returns: void
     */
    func update(transformer: Transformer, _ completion: @escaping TransformerHandler) {
        print(#function)
        
        retrieveToken { [weak self] (_, _) in
            
            self?.provider.request(.update(transformer: transformer)) { (result) in
                
                switch result {
                case let .success(moyaResponse):
                    print(moyaResponse.statusCode)

                    switch moyaResponse.statusCode { // Int - 200, 401, 500, etc
                    case 200..<300:
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let transformer = try? decoder.decode(Transformer.self, from: moyaResponse.data)
                        completion(transformer, nil)
                    default:
                        completion(nil, MyError.unknown)
                    }
                    
                case let .failure(error):
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
        }
    }
    
    /**
     Deletes a transformer
     ```
     First check if we have the token calling retrieveToken method.
     We need to have at least the id of the transformer
     
     ```
     - parameter transformer: Transformer
     - parameter completion: SuccessHandler?
     - returns: void
     */
    func delete(transformer: Transformer, _ completion: @escaping SuccessHandler) {
        print(#function)
        
        retrieveToken { [weak self] (_, _) in
            self?.provider.request(.delete(transformer: transformer)) { (result) in
                switch result {
                case let .success(moyaResponse):
                    
                    switch moyaResponse.statusCode { // Int - 200, 401, 500, etc
                    case 200..<300: completion(true, nil)
                    default: completion(false, MyError.failDeletion)
                    }
            
                case let .failure(error):
                    print(error.localizedDescription)
                    completion(false, error)
                }
            }
        }
    }
}
