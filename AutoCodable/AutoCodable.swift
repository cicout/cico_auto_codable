//
//  AutoProtocol.swift
//  AutoCodable
//
//  Created by lucky.li on 2018/6/4.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation

private let kDefaultJSONDecoder = JSONDecoder()
private let kDefaultJSONEncoder = JSONEncoder()

public protocol AutoCodable: Codable {}

public extension Decodable {
    public init?(jsonData: Data, jsonDecoder: JSONDecoder? = nil) {
        let decoder: JSONDecoder
        if let jsonDecoder = jsonDecoder {
            decoder = jsonDecoder
        } else {
            decoder = kDefaultJSONDecoder
        }
        
        if let object: Self = decoder.decodeData(Self.self, from: jsonData) {
            self = object
        } else {
            return nil
        }
    }
    
    public init?(jsonString: String, jsonDecoder: JSONDecoder? = nil) {
        let decoder: JSONDecoder
        if let jsonDecoder = jsonDecoder {
            decoder = jsonDecoder
        } else {
            decoder = kDefaultJSONDecoder
        }
        
        if let object: Self = decoder.decodeString(Self.self, from: jsonString) {
            self = object
        } else {
            return nil
        }
    }
}

public extension Encodable {
    public func toJSONData(jsonEncoder: JSONEncoder? = nil) -> Data? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = kDefaultJSONEncoder
        }
        
        return encoder.encodeToData(object: self)
    }
    
    public func toJSONString(jsonEncoder: JSONEncoder? = nil) -> String? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = kDefaultJSONEncoder
        }
        
        return encoder.encodeToString(object: self)
    }
}


