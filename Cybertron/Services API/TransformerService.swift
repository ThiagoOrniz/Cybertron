//
//  TransformerService.swift
//  Cybertron
//
//  Created by Thiago Orniz Martin on 2018-10-20.
//  Copyright © 2018 Thiago Orniz Martin. All rights reserved.
//

import Foundation
import Moya

enum TransformerService {
    case allSpark
    case transformers
    case create(transformer: Transformer)
    case update(transformer: Transformer)
    case delete(transformer: Transformer)
}

// MARK: - TargetType Protocol Implementation
extension TransformerService: TargetType {
    var baseURL: URL { return URL(string: "https://transformers-api.firebaseapp.com")! }
    
    var path: String {
        switch self {
        case .allSpark:
            return "/allSpark"
        case .transformers, .create, .update:
            return "/transformers"
        case let .delete(transformer):
            return "/transformers/\(transformer.id ?? "")"
        }
    }
    var method: Moya.Method {
        switch self {
        case .allSpark, .transformers:
            return .get
        case .create:
            return .post
        case .update:
            return .put
        case .delete:
            return .delete
        }
    }
    var task: Task {
        switch self {
        case .allSpark, .transformers, .delete:
            return .requestPlain
        case let .create(transformer):
            return .requestParameters(parameters: ["name": transformer.name ?? "",
                                                   "strength": transformer.strength,
                                                   "intelligence": transformer.intelligence,
                                                   "speed": transformer.speed,
                                                   "endurance": transformer.endurance,
                                                   "rank": transformer.rank,
                                                   "courage": transformer.courage,
                                                   "firepower": transformer.firepower,
                                                   "skill": transformer.skill,
                                                   "team": transformer.team ?? ""], encoding: JSONEncoding.default)
        case let .update(transformer):
            return .requestParameters(parameters: ["id": transformer.id ?? "",
                                                   "name": transformer.name ?? "",
                                                   "strength": transformer.strength,
                                                   "intelligence": transformer.intelligence,
                                                   "speed": transformer.speed,
                                                   "endurance": transformer.endurance,
                                                   "rank": transformer.rank,
                                                   "courage": transformer.courage,
                                                   "firepower": transformer.firepower,
                                                   "skill": transformer.skill,
                                                   "team": transformer.team ?? ""], encoding: JSONEncoding.default)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .allSpark:
            return "A JWT token to be attached to the header of all requests".utf8Encoded
        case .transformers:
            return "{\"transformers\": [{\"id\":0, \"name\": \"autobot1\",\"team\": \"A\"}]}".utf8Encoded
        case let .create(transformer):
            return "{\"transformers\": [{\"id\":0, \"name\": \(transformer.name ?? ""),\"team\": \(transformer.team ?? "A")}]}".utf8Encoded
        case let .update(transformer):
            return "{\"transformers\": [{\"id\":0, \"name\": \(transformer.name ?? ""),\"team\": \(transformer.team ?? "A")}]}".utf8Encoded
        case .delete:
            return "".utf8Encoded
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .allSpark, .transformers, .create, .update, .delete:
            return ["Content-type": "application/json"]
        }
    }
}

// MARK: - AccessTokenAuthorizable
extension TransformerService: AccessTokenAuthorizable {
    
    var authorizationType: AuthorizationType {
        switch self {
        case .allSpark: return .none
        case .transformers, .create, .update, .delete: return .bearer
        }
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
