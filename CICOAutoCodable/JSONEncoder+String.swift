//
//  JSONEncoder+String.swift
//  AutoCodable
//
//  Created by lucky.li on 2018/6/5.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation

public extension JSONEncoder {
    /// Encode object to JSON data;
    ///
    /// - parameter object: encodable object;
    ///
    /// - returns: JSON data, nil when invalid;
    public func encodeToJSONData<T: Encodable>(object: T) -> Data? {
        do {
            let data = try self.encode(object)
            return data
        } catch let error {
            print("[JSON_ENCODE_ERROR]: \(error)")
            return nil
        }
    }
    
    /// Encode object to JSON string;
    ///
    /// - parameter object: encodable object;
    ///
    /// - returns: JSON string, nil when invalid;
    public func encodeToJSONString<T: Encodable>(object: T) -> String? {
        guard let jsonData = self.encodeToJSONData(object: object) else {
            return nil
        }
        
        let jsonString = String.init(data: jsonData, encoding: .utf8)
        return jsonString
    }
    
    /// Encode object to JSON object;
    ///
    /// - parameter object: encodable object;
    ///
    /// - returns: JSON object, nil when invalid;
    ///
    /// - see: JSONSerialization.jsonObject(with:options:)
    public func encodeToJSONObject<T: Encodable>(object: T) -> Any? {
        guard let jsonData = self.encodeToJSONData(object: object) else {
            return nil
        }
        
        do {
            let object = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            return object
        } catch let error {
            print("[JSON_SERIALIZATION_ERROR]: \(error)")
            return nil
        }
    }
}
