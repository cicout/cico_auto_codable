//
//  JSONDecoder+String.swift
//  AutoCodable
//
//  Created by lucky.li on 2018/6/5.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation

public extension JSONDecoder {
    /// Decode JSON data to decodable object;
    ///
    /// - parameter type: Decodable object type;
    /// - parameter jsonData: JSON encoded data;
    ///
    /// - returns: Decodable object, nil when invalid JSON data;
    public func decodeJSONData<T: Decodable>(_ type: T.Type, from jsonData: Data) -> T? {
        do {
            let object = try self.decode(type, from: jsonData)
            return object
        } catch let error {
            print("[JSON_DECODE_ERROR]: \(error)")
            return nil
        }
    }
    
    /// Decode JSON string to decodable object;
    ///
    /// - parameter type: Decodable object type;
    /// - parameter jsonString: JSON encoded string;
    ///
    /// - returns: Decodable object, nil when invalid JSON string;
    public func decodeJSONString<T: Decodable>(_ type: T.Type, from jsonString: String) -> T? {
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        
        let object = self.decodeJSONData(T.self, from: jsonData)
        return object
    }
    
    /// Decode JSON object to decodable object;
    ///
    /// - parameter type: Decodable object type;
    /// - parameter jsonObject: JSON encoded object, it must be json array or json dictionary;
    ///                         It will be transfered to JSON data using JSONSerialization;
    ///
    /// - returns: Decodable object, nil when invalid JSON object;
    ///
    /// - see: JSONSerialization.isValidJSONObject(_)
    public func decodeJSONObject<T: Decodable>(_ type: T.Type, from jsonObject: Any) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            let object = self.decodeJSONData(T.self, from: jsonData)
            return object
        } catch let error {
            print("[JSON_SERIALIZATION_ERROR]: \(error)")
            return nil
        }
    }
}
