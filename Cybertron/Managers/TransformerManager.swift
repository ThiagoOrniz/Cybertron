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

class TransformerManager {
    
    var provider = MoyaProvider<TransformerService>()

    var token: String? {
        return UserDefaults.standard.string(forKey: Const.UserDefaultKeys.tokenKey)
    }
    
    init() {
        if let token = token {
            let authPlugin = AccessTokenPlugin(tokenClosure: token)
            provider = MoyaProvider<TransformerService>(plugins: [authPlugin])
        }
    }
    
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
                guard let newToken = String(data: moyaResponse.data, encoding: .utf8) else {
                    UserDefaults.standard.set(nil, forKey: Const.UserDefaultKeys.tokenKey)
                    completion?(nil, MyError.failToken)
                    return
                }
                
                UserDefaults.standard.set(newToken, forKey: Const.UserDefaultKeys.tokenKey)
                
                let authPlugin = AccessTokenPlugin(tokenClosure: newToken)
                self?.provider = MoyaProvider<TransformerService>(plugins: [authPlugin])
                
                completion?(newToken, nil)
            case let .failure(error):
                print(error.localizedDescription)
                UserDefaults.standard.set(nil, forKey: Const.UserDefaultKeys.tokenKey)
                completion?(nil, error)
            }
        }
    }
    
    func fetchAll(_ completion: @escaping TransformerListHandler) {
        print(#function)
        
        retrieveToken { [weak self] (_, _) in
            self?.provider.request(.transformers) { (result) in
                print("Response of transformers")

                switch result {
                case let .success(moyaResponse):
                    print(moyaResponse.statusCode)

                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                    let transformers = try? decoder.decode([String: [Transformer]].self, from: moyaResponse.data)
                    completion(transformers?["transformers"] ?? [], nil)
                case let .failure(error):
                    print(error.localizedDescription)
                    completion([], error)
                }
            }
        }
    }
    
    func create(transformer: Transformer, _ completion: @escaping TransformerHandler) {
        print(#function)
        
        retrieveToken { [weak self] (_, _) in
            
            print(transformer)
            print("--------")
            self?.provider.request(.create(transformer: transformer)) { (result) in
                print("Response of create")
                
                switch result {
                case let .success(moyaResponse):
                    print(moyaResponse.statusCode)

                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let transformer = try? decoder.decode(Transformer.self, from: moyaResponse.data)
                    print(transformer)
                    
                    completion(transformer, nil)
                    
                case let .failure(error):
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
        }
    }
    
    func update(transformer: Transformer, _ completion: @escaping TransformerHandler) {
        print(#function)
        
        retrieveToken { [weak self] (_, _) in
            
            print(transformer)
            print("--------")
            self?.provider.request(.update(transformer: transformer)) { (result) in
                print("Response of create")
                
                switch result {
                case let .success(moyaResponse):
                    print(moyaResponse.statusCode)
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let transformer = try? decoder.decode(Transformer.self, from: moyaResponse.data)
                    print(transformer)
                    
                    completion(transformer, nil)
                    
                case let .failure(error):
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
        }
    }
    
    func delete(transformer: Transformer, _ completion: @escaping SuccessHandler) {
        print(#function)
        
        retrieveToken { [weak self] (_, _) in
            
            print(transformer)
            print("--------")
            self?.provider.request(.delete(transformer: transformer)) { (result) in
                print("Response of create")
                
                switch result {
                case let .success(_):
                    completion(true, nil)
                    
                case let .failure(error):
                    print(error.localizedDescription)
                    completion(false, error)
                }
            }
        }
    }
}
