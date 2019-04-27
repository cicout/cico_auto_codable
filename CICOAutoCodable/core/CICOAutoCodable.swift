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

public protocol CICOAutoCodable: Codable {}

public extension Decodable {
    /// Init with JSON data;
    ///
    /// - parameter jsonData: JSON encoded data;
    /// - parameter jsonDecoder: JSON decoder, it will use default JSONDecoder when nil;
    ///
    /// - returns: Init object, nil when invalid JSON data;
    init?(jsonData: Data, jsonDecoder: JSONDecoder? = nil) {
        let decoder: JSONDecoder
        if let jsonDecoder = jsonDecoder {
            decoder = jsonDecoder
        } else {
            decoder = kDefaultJSONDecoder
        }
        
        if let object: Self = decoder.decodeJSONData(Self.self, from: jsonData) {
            self = object
        } else {
            return nil
        }
    }
    
    /// Init with JSON string;
    ///
    /// - parameter jsonString: JSON encoded string;
    /// - parameter jsonDecoder: JSON decoder, it will use default JSONDecoder when nil;
    ///
    /// - returns: Init object, nil when invalid JSON string;
    init?(jsonString: String, jsonDecoder: JSONDecoder? = nil) {
        let decoder: JSONDecoder
        if let jsonDecoder = jsonDecoder {
            decoder = jsonDecoder
        } else {
            decoder = kDefaultJSONDecoder
        }
        
        if let object: Self = decoder.decodeJSONString(Self.self, from: jsonString) {
            self = object
        } else {
            return nil
        }
    }
    
    /// Init with JSON object(Array/Dictionary);
    ///
    /// - parameter jsonObject: JSON encoded object, it must be json array or json dictionary;
    ///                         It will be transfered to JSON data using JSONSerialization;
    /// - parameter jsonDecoder: JSON decoder, it will use default JSONDecoder when nil;
    ///
    /// - returns: Init object, nil when invalid JSON object;
    ///
    /// - see: JSONSerialization.isValidJSONObject(_)
    init?(jsonObject: Any, jsonDecoder: JSONDecoder? = nil) {
        let decoder: JSONDecoder
        if let jsonDecoder = jsonDecoder {
            decoder = jsonDecoder
        } else {
            decoder = kDefaultJSONDecoder
        }
        
        if let object: Self = decoder.decodeJSONObject(Self.self, from: jsonObject) {
            self = object
        } else {
            return nil
        }
    }
}

public extension Encodable {
    /// Transfer self to JSON data;
    ///
    /// - parameter jsonEncoder: JSON encoder, it will use default JSONEncoder when nil;
    ///
    /// - returns: JSON data, nil when invalid;
    func toJSONData(jsonEncoder: JSONEncoder? = nil) -> Data? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = kDefaultJSONEncoder
        }
        
        return encoder.encodeToJSONData(object: self)
    }
    
    /// Transfer self to JSON string;
    ///
    /// - parameter jsonEncoder: JSON encoder, it will use default JSONEncoder when nil;
    ///
    /// - returns: JSON string, nil when invalid;
    func toJSONString(jsonEncoder: JSONEncoder? = nil) -> String? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = kDefaultJSONEncoder
        }
        
        return encoder.encodeToJSONString(object: self)
    }
    
    /// Transfer self to JSON object;
    ///
    /// - parameter jsonEncoder: JSON encoder, it will use default JSONEncoder when nil;
    ///
    /// - returns: JSON object, nil when invalid;
    ///
    /// - see: JSONSerialization.jsonObject(with:options:)
    func toJSONObject(jsonEncoder: JSONEncoder? = nil) -> Any? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = kDefaultJSONEncoder
        }
        
        return encoder.encodeToJSONObject(object: self)
    }
}


