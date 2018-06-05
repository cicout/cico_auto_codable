//
//  AutoProtocol.swift
//  AutoCodable
//
//  Created by lucky.li on 2018/6/4.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation

public protocol AutoDecodable: Decodable {}
public protocol AutoEncodable: Encodable {}
public protocol AutoCodableBase: AutoDecodable, AutoEncodable {}

public protocol AutoCodable: AutoCodableBase {}

public extension AutoCodable {
    public init?(jsonData: Data, jsonDecoder: JSONDecoder? = nil) {
        let decoder: JSONDecoder
        if let jsonDecoder = jsonDecoder {
            decoder = jsonDecoder
        } else {
            decoder = JSONDecoder()
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
            decoder = JSONDecoder()
        }
        
        if let object: Self = decoder.decodeString(Self.self, from: jsonString) {
            self = object
        } else {
            return nil
        }
    }
    
    public func toJSONData(jsonEncoder: JSONEncoder? = nil) -> Data? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = JSONEncoder()
        }
        
        return encoder.encodeToData(object: self)
    }
    
    public func toJSONString(jsonEncoder: JSONEncoder? = nil) -> String? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = JSONEncoder()
        }
        
        return encoder.encodeToString(object: self)
    }
}

public extension Array where Element: Codable {
    public init?(jsonData: Data, jsonDecoder: JSONDecoder? = nil) {
        let decoder: JSONDecoder
        if let jsonDecoder = jsonDecoder {
            decoder = jsonDecoder
        } else {
            decoder = JSONDecoder()
        }
        
        if let object: Array<Element> = decoder.decodeData(Array<Element>.self, from: jsonData) {
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
            decoder = JSONDecoder()
        }
        
        if let object: Array<Element> = decoder.decodeString(Array<Element>.self, from: jsonString) {
            self = object
        } else {
            return nil
        }
    }
    
    public func toJSONData(jsonEncoder: JSONEncoder? = nil) -> Data? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = JSONEncoder()
        }
        
        return encoder.encodeToData(object: self)
    }
    
    public func toJSONString(jsonEncoder: JSONEncoder? = nil) -> String? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = JSONEncoder()
        }
        
        return encoder.encodeToString(object: self)
    }
}

public extension Set where Element: Codable {
    public init?(jsonData: Data, jsonDecoder: JSONDecoder? = nil) {
        let decoder: JSONDecoder
        if let jsonDecoder = jsonDecoder {
            decoder = jsonDecoder
        } else {
            decoder = JSONDecoder()
        }
        
        if let object: Set<Element> = decoder.decodeData(Set<Element>.self, from: jsonData) {
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
            decoder = JSONDecoder()
        }
        
        if let object: Set<Element> = decoder.decodeString(Set<Element>.self, from: jsonString) {
            self = object
        } else {
            return nil
        }
    }
    
    public func toJSONData(jsonEncoder: JSONEncoder? = nil) -> Data? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = JSONEncoder()
        }
        
        return encoder.encodeToData(object: self)
    }
    
    public func toJSONString(jsonEncoder: JSONEncoder? = nil) -> String? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = JSONEncoder()
        }
        
        return encoder.encodeToString(object: self)
    }
}

public extension Dictionary where Key: Codable, Value: Codable {
    public init?(jsonData: Data, jsonDecoder: JSONDecoder? = nil) {
        let decoder: JSONDecoder
        if let jsonDecoder = jsonDecoder {
            decoder = jsonDecoder
        } else {
            decoder = JSONDecoder()
        }
        
        if let object: Dictionary<Key, Value> = decoder.decodeData(Dictionary<Key, Value>.self, from: jsonData) {
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
            decoder = JSONDecoder()
        }
        
        if let object: Dictionary<Key, Value> = decoder.decodeString(Dictionary<Key, Value>.self, from: jsonString) {
            self = object
        } else {
            return nil
        }
    }
    
    public func toJSONData(jsonEncoder: JSONEncoder? = nil) -> Data? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = JSONEncoder()
        }
        
        return encoder.encodeToData(object: self)
    }
    
    public func toJSONString(jsonEncoder: JSONEncoder? = nil) -> String? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = JSONEncoder()
        }
        
        return encoder.encodeToString(object: self)
    }
}
